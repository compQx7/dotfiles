# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	  *) return;;
esac

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -nl|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# my_setting
eval $(dircolors -b ~/.dircolors)

# Search the command history and expand it to the command line.
__fzf_history() {
	local cmd
	cmd=$(history |
		# Delete the numbers, sort them by newest, and output only the first one.
		sed 's/ *[0-9]* *//' | tac | awk '!seen[$0]++' |
		fzf --no-sort --reverse --bind=ctrl-s:toggle-sort --bind 'ctrl-e:accept,tab:accept')

	if [[ -n $cmd ]]; then
		READLINE_LINE="$cmd"
		READLINE_POINT=${#cmd}
	fi
}
# Assign(Override) history search to Ctrl-r.
bind -x '"\C-r": __fzf_history'

__git_commit_browser() {
	git log --graph --color=always \
		--format="%C(red)%h %C(green)(%cd)%C(yellow)%d %C(reset)%s %C(bold blue)<%an>%C(reset)" --date=format:'%Y-%m-%d %H:%M:%S' "$@" |
	fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
		--bind "ctrl-m:execute:
			(grep -o '[a-f0-9]\{7\}' | head -1 |
			xargs -I % sh -c 'git show % | delta | less -R') << 'FZF-EOF'
			{}
FZF-EOF"
}

__git_diff_browser() {
	local args="$*"
	git diff --name-only \
		$args |
	fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
		--bind "ctrl-m:execute:
			(head -1 |
			xargs -I % sh -c 'git diff $args -- \"%\" | delta | less -R') << 'FZF-EOF'
			{}
FZF-EOF"
}

__cd_fzf() {
	local dir
	dir=$(find ${1:-.} -path '*/\.*' -prune \
					-o -type d -print 2> /dev/null | fzf +m) &&
	cd "$dir"
}
__cd_git_root() {
	cd $(git rev-parse --show-toplevel)
}

# -------------------------
# Private function for recursive tree display
#   _tree_with_lines <directory> <prefix> <current_depth> <max_depth> <excludes_array...>
# -------------------------
_tree_with_lines() {
	local dir="$1"
	local prefix="$2"
	local current_depth="$3"
	local max_depth="$4"
	shift 4
	local excludes=("$@")  # Rest arguments as an array (.git, node_modules, etc.)

	# Get a list of elements in a directory (including hidden files)
	local items=()
	mapfile -t items < <(ls -A "$dir" 2>/dev/null || true)

	local count=${#items[@]}
	local i=0

	for item in "${items[@]}"; do
		((i++))
		local path="$dir/$item"

		# ---------- Exclusion Check ----------
		# If it is included in the excludes array, it will be skipped.
		local skip=""
		for exc in "${excludes[@]}"; do
			if [[ "$item" == "$exc" ]]; then
				skip=1
				break
			fi
		done
		[ -n "$skip" ] && continue
		# ---------------------------------

		# Set the tree branch characters
		local branch="├──"
		[ $i -eq $count ] && branch="└──"  # If it is the last element, use "└──"

		if [ -d "$path" ]; then
			# In the case of a directory, the line number is not displayed and the output is as is.
			echo "${prefix}${branch} $item"

			# If max_depth has not been reached yet, recurse down
			if [ "$current_depth" -lt "$max_depth" ]; then
				local new_prefix="${prefix}│   "
				[ $i -eq $count ] && new_prefix="${prefix}    "
				_tree_with_lines "$path" "$new_prefix" $((current_depth + 1)) "$max_depth" "${excludes[@]}"
			fi
		else
			# If it is a file, get the number of lines (0 on failure)
			local lines
			lines=$(wc -l < "$path" 2>/dev/null || echo 0)
			echo "${prefix}${branch} $item  ($lines lines)"
		fi
	done
}

# -------------------------
# 
#   tree_with_lines [<directory>] [<max_depth>] [--exclude <dir_to_exclude> ...]
# -------------------------
__tree_with_lines() {
	local target_dir="."
	local max_depth="1"

	# Default exclusion list
	local EXCLUDES=( ".git" )

	# For argument analysis
	while [ $# -gt 0 ]; do
		case "$1" in
			# Add to the exclude list when called with the --exclude <dir> form
			-x|--exclude)
				if [ -n "$2" ]; then
					EXCLUDES+=("$2")
					shift 2
				else
					echo "ERROR: The --exclude option must be followed by the name of the directory to be excluded." >&2
					return 1
				fi
				;;
			-d|--depth)
				if [ -n "$2" ]; then
					max_depth="$2"
					max_depth_specified=1
					shift 2
				else
					echo "ERROR: The -d option is required followed by depth." >&2
					return 1
				fi
				;;
			*)
				if [ -n "$1" ]; then
					target_dir="$1"
					target_dir_specified=1
					shift 1
				else
					echo "ERROR: The -p option must be followed by a path." >&2
					return 1
				fi
				;;
		esac
	done

	# Show top-level directory name (optional if necessary)
	echo "$target_dir"

	# If the hierarchy depth is 1 or more, search below
	if [ "$max_depth" -ge 1 ]; then
		_tree_with_lines "$target_dir" "" 1 "$max_depth" "${EXCLUDES[@]}"
	fi
}

# The operating system type for dotfiles configuration scripts
export DOTFILES_OS_TYPE=linux
# default less options
export LESS='-i -M -R'

alias cdf="__cd_fzf"
alias cdh="cd ~"
alias cdr="__cd_git_root"
alias dc="docker compose"
alias dcu="docker compose up -d"
alias dcd="docker compose down"
alias dirs="dirs -v"
alias doc="docker container"
alias doce="docker container exec -it"
alias docl="docker container ls"
alias docr="docker container run"
alias doi="docker image"
alias doib="docker image build"
alias doil="docker image ls"
alias don="docker network"
alias dov="docker volume"
alias g="git"
alias gshow="__git_commit_browser"
alias hist="history"
alias lg="lazygit"
alias gd="pushd"
alias gdf="__git_diff_browser"
alias ghs="gh search"
alias ghsr="gh search repos --sort=stars --order=desc"
alias pd="popd"
alias repo="cd ~/ghq/\$(ghq list | fzf --reverse)"
alias tm="tmux"
alias tree="__tree_with_lines"
alias vi="nvim"
alias vim="nvim"
alias virepo="cd ~/ghq/\$(ghq list | fzf --reverse) && vi"

EDITOR=vi

# Command line editing in vi mode
# set -o vi

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# . "/home/linuxbrew/.linuxbrew/opt/asdf/libexec/asdf.sh"
# . "/home/linuxbrew/.linuxbrew/opt/asdf/etc/bash_completion.d/asdf"
eval "$(mise activate bash)"

# Load additional settings from another file
if [ -f ~/.bashrc.local ]; then
	source ~/.bashrc.local
fi

