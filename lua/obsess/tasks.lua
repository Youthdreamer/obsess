local config = require("obsess.config")
local ui = require("obsess.ui")
local state = config.state

local M = {}

-- 创建持久化文件
local create_obsess_file = function(obsess_file)
  if type(obsess_file) == 'nil' then
    return
  end

  if vim.fn.filereadable(obsess_file) == 0 then
    -- 文件不存在创建文件
    local dir = vim.fn.fnamemodify(obsess_file, ':h')

    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
    vim.fn.writefile("[]", obsess_file) -- 创建持久化json文件
  end
end

local save_obsess_json = function(data, obsess_file)
  if type(obsess_file) == 'nil' then
    return
  end
  local data_final = setmetatable(data, vim.json.array)
  local json_str = vim.json.encode(data_final, { indent = " " })
  vim.fn.writefile(vim.split(json_str, "\n"), obsess_file)
end

--- 更新 buffer，把剩余时间 + 任务列表一起写入
---@param header? string
function M.render(header)
  ui.ensure_visible_buffer()

  header = tostring(header or "")

  local width = 30
  if config.options and config.options.window and config.options.window.width then
    width = config.options.window.width
  end

  -- 居中 header
  local pad = math.max(0, math.floor((width - #header) / 2))
  local header_line = string.rep(" ", pad) .. header

  local lines = { header_line }
  for i, task in ipairs(state.tasks) do
    local mark = task.done and "✓" or " "
    table.insert(lines, string.format("[%s] %d. %s", mark, i, task.text))
  end

  vim.bo[state.buf].modifiable = true
  vim.bo[state.buf].readonly = false
  vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, lines)
  vim.bo[state.buf].modifiable = false
  vim.bo[state.buf].readonly = true
end

--- 添加任务
---@param text string
function M.add(text)
  create_obsess_file(config.obsess_file) -- 只在 首次添加任务时创建文件
  table.insert(state.tasks, { text = text, done = false })
  save_obsess_json(state.tasks, config.obsess_file)
  M.render()
end

--- 删除任务
---@param index number
function M.remove(index)
  table.remove(state.tasks, index)
  save_obsess_json(state.tasks, config.obsess_file)
  M.render()
end

--- 标记任务完成/未完成
---@param index number
function M.toggle_done(index)
  local task = state.tasks[index]
  if task then
    task.done = not task.done
    save_obsess_json(state.tasks, config.obsess_file)
    M.render()
  end
end

--- 加载任务
function M.load()
  if state.tasks == nil or next(state.tasks) == nil then
    vim.notify("No tasks to load", vim.log.levels.WARN)
  end
  M.render()
end

--- 清空所有任务
function M.clear()
  state.tasks = {}
  save_obsess_json(state.tasks, config.obsess_file)
  M.render()
end

return M
