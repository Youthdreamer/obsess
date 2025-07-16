local config = require("obsess.config")
local timer = require("obsess.timer")
local ui = require("obsess.ui")
local tasks = require("obsess.tasks")
local command = require("obsess.commands")

local M = {}

function M.setup(opts)
	config.setup(opts)
	command.setup()
end

-- 提供函数外部调用
M.close_win = ui.close -- 注销窗口

M.toggle_win = ui.toggle_win

M.timer = timer.timer -- 定时器
M.start = timer.start -- 倒计时核心函数

M.tasks_add = tasks.add
M.tasks_del = tasks.remove
M.tasks_toggle = tasks.toggle_done
M.tasks_clear = tasks.clear

return M
