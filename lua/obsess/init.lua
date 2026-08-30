local config = require("obsess.config")
local timer = require("obsess.timer")
local ui = require("obsess.ui")
local tasks = require("obsess.tasks")
local command = require("obsess.commands")

local M = {}

-- 创建持久化文件，读取文件内容
local init_obsess_file = function(obsess_file)
  if vim.fn.filereadable(obsess_file) == 1 then
    -- 文件存在读取内容，并写入到。config.state.tasks
    local ok, res = pcall(function()
      local lines = vim.fn.readfile(obsess_file)
      local raw = table.concat(lines, "\n")
      local obsess_table = vim.json.decode(raw)
      config.state.tasks = obsess_table
    end)
    if not ok then
      vim.notify(string.format("JSON file is malformed. please chaeck at: %s", obsess_file), vim.log.levels.ERROR)
      config.state.tasks = {}
      return nil
    end
    return res
  else
    -- 文件不存在创建文件
    local dir = vim.fn.fnamemodify(obsess_file, ':h')

    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
    vim.fn.writefile("[]", obsess_file) -- 创建持久化json文件
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

return M
