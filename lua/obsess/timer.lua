local config = require("obsess.config")
local ui = require("obsess.ui")
local state = config.state

local M = {}

--- 格式化剩余时间
local function format_time(seconds)
	return string.format("%02d:%02d", math.floor(seconds / 60), seconds % 60)
end

--- 更新 buffer 的第一行
local function update_line(buf, text)
	ui.ensure_visible_buffer()

	if not vim.api.nvim_buf_is_valid(buf) then
		vim.notify("update_line: Window or buffer is invalid, unable to update", vim.log.levels.WARN)
		return
	end

	text = tostring(text) -- 这里强制转字符串，避免报错

	local width = 30 -- 默认宽度
	if config.options and config.options.window and config.options.window.width then
		width = config.options.window.width
	end

	local pad = math.max(0, math.floor((width - #text) / 2))

	local line = string.rep(" ", pad) .. text

	-- 临时允许写入，写完再锁定
	vim.bo[buf].modifiable = true
	vim.bo[state.buf].readonly = false
	vim.api.nvim_buf_set_lines(buf, 0, 1, false, { line })
	vim.bo[buf].modifiable = false
	vim.bo[state.buf].readonly = true
end

local function flash_border()
	local times = config.options.flash.times -- 默认闪烁次数（6次即3次完整切换）
	local interval_ms = config.options.flash.interval_ms -- 每次切换持续时间，默认500毫秒

	if not state.win_id or not vim.api.nvim_win_is_valid(state.win_id) then
		ui.toggle_win() -- 窗口隐藏时先打开
	end
	local win = state.win_id
	if not win or not vim.api.nvim_win_is_valid(win) then
		return
	end

	local cfg = vim.api.nvim_win_get_config(win)
	local original_border = cfg.border or "rounded"
	local border = "double"

	local count = 0

	local function toggle()
		if count >= times then
			cfg.border = original_border
			vim.api.nvim_win_set_config(win, cfg)
			return
		end
		if count % 2 == 0 then
			cfg.border = border
		else
			cfg.border = original_border
		end
		vim.api.nvim_win_set_config(win, cfg)
		count = count + 1
		vim.defer_fn(toggle, interval_ms)
	end

	toggle()
end

--- 启动倒计时
---@param duration number  总秒数
M.start = function(duration)
	local buf = state.buf
	local win = state.win_id

	if not buf or not vim.api.nvim_buf_is_valid(buf) then
		vim.notify("Buffer is invalid, please open the window first", vim.log.levels.ERROR)
		return
	end
	if not win or not vim.api.nvim_win_is_valid(win) then
		vim.notify("Window is invalid, please open the window first", vim.log.levels.ERROR)
		return
	end

	if state.running then
		vim.notify("Timer already running", vim.log.levels.WARN)
		return
	end

	state.running = true
	local remaining = duration

	local function tick()
		if not state.running then
			vim.notify("Timer destruction", vim.log.levels.INFO)
			return
		end

		if remaining < 0 then
			update_line(buf, "⏰ Time's up!")

			flash_border() -- 默认：10次闪烁，每次300ms

			return
		end

		-- 如果窗口或缓冲区无效，停止定时器
		if not vim.api.nvim_buf_is_valid(buf) then
			return
		end

		update_line(buf, format_time(remaining))
		remaining = remaining - 1

		vim.defer_fn(tick, 1000)
	end

	tick()
end

local start_minutes = function(minutes)
	return M.start(minutes * 60)
end

M.timer = function()
	ui.ensure_visible_buffer()
	vim.ui.input({ text = "Enter minutes: ", default = tostring(config.options.time.minute or 0) }, function(input)
		local minutes = tonumber(input)
		if minutes then
			start_minutes(minutes)
		end
	end)
end

M.timer_sec = function()
	ui.ensure_visible_buffer()
	vim.ui.input({ text = "Enter second: ", default = tostring(config.options.time.second or 0)}, function(input)
		local second = tonumber(input)
		if second then
			M.start(second)
		end
	end)
end

return M
