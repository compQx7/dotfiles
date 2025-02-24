local plug = {
  'rcarriga/nvim-notify',
	config = function()
		require('notify').setup({
			-- stages = 'slide', -- 通知のアニメーションスタイル
			stages = 'fade_in_slide_out', -- 通知のアニメーションスタイル
			timeout = 4000,  -- 通知の表示時間 (ミリ秒)
			background_colour = '#1e222a',  -- 背景色を設定
			render = 'minimal',             -- シンプルな通知スタイル
			-- task_list = {
			-- 	direction = 'right', -- タスク一覧の方向
			-- },
		})
		vim.notify = require('notify')
	end,
}

return plug

