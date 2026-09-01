local config = require("obsess.config")
local timer = require("obsess.timer")
local ui = require("obsess.ui")
local tasks = require("obsess.tasks")
local command = require("obsess.commands")

local M = {}


-- 读取文件内容
local init_obsess_file = function(obsess_file)
  -- 文件不存在：初始化空任务，静默返回（不报错）
  if vim.fn.filereadable(obsess_file) == 0 then
    config.state.tasks = {}
    return
  end
  -- 文件存在读取内容，并写入到。config.state.tasks
  local ok, obsess_tasks_table = pcall(function()
    local raw = table.concat(vim.fn.readfile(obsess_file), "\n")
    return vim.json.decode(raw)
  end)
  -- 处理
  if ok then
    config.state.tasks = obsess_tasks_table
  else
    -- 解析失败提示错误
    vim.notify(string.format("JSON file is malformed. please chaeck at: %s", obsess_file), vim.log.levels.ERROR)
    config.state.tasks = {}
  end
end

function M.setup(opts)
  config.setup(opts)
  command.setup()
  init_obsess_file(config.obsess_file)
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
M.tasks_load = tasks.load

return M
