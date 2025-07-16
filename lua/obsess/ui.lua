local config = require("obsess.config")
local state = config.state

local M = {}

M.toggle_win = function()
	if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
		vim.notify("No active timer to toggle. Start it first.", vim.log.levels.WARN)
		return
	end

	if state.win_id and vim.api.nvim_win_is_valid(state.win_id) then
		-- 窗口当前显示 → 关闭窗口，但不销毁状态
		vim.api.nvim_win_close(state.win_id, true)
		state.win_id = nil
	else
		-- 窗口未显示 → 用已有 buffer 重新打开
		local opts = config.options
		if not opts.window then
			vim.notify("Config not initialized. Please call setup() first!", vim.log.levels.ERROR)
			return
		end

		state.win_id = vim.api.nvim_open_win(state.buf, false, opts.window)
	end
end

M.open = function()
	local opts = config.options
	if not opts.window then
		vim.notify("Config not initialized. Please call setup() first!", vim.log.levels.ERROR)
		return
	end

	if state.buf then
		vim.notify("Window is Hidden!", vim.log.levels.INFO)
		M.toggle_win()
	end
	if not state.buf or not state.win_id or not vim.api.nvim_win_is_valid(state.win_id) then -- 检查是否有效的窗口生成
		state.buf = vim.api.nvim_create_buf(false, false) -- 新建缓冲区
		-- 设置 buffer 选项
		vim.bo[state.buf].buftype = "nofile"
		vim.bo[state.buf].bufhidden = "hide"
		vim.bo[state.buf].modifiable = false
		vim.bo[state.buf].readonly = true

		state.win_id = vim.api.nvim_open_win(state.buf, false, opts.window) -- 返回打开的窗口id
		vim.wo[state.win_id].number = false
		vim.wo[state.win_id].relativenumber = false
		vim.wo[state.win_id].cursorline = false
		vim.wo[state.win_id].signcolumn = "no"
		vim.wo[state.win_id].wrap = true
	else
		vim.notify("Window is already open!", vim.log.levels.INFO)
	end
end

-- 销毁定时器 + 窗口 + 缓冲区
M.close = function()
	if state.timer then
		state.timer = false
	end

	if state.win_id and vim.api.nvim_win_is_valid(state.win_id) then
		vim.api.nvim_win_close(state.win_id, true)
	end

	if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
		vim.api.nvim_buf_delete(state.buf, { force = true })
	end

	state.win_id = nil
	state.buf = nil
	state.running = false
end

--- 确保 buffer 和 window 存在
function M.ensure_visible_buffer()
	if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
		M.open()
	end
end

return M
