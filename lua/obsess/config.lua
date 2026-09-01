local M = {}

--- @type table
local default_marker = { ".git" }

---@class FlashConfig
---@field times integer 闪烁次数
---@field interval_ms integer 每次间隔（毫秒）

---@type FlashConfig
local default_flash = {
  times = 6,
  interval_ms = 300,
}

---@class TimeConfig
---@field minute integer 默认分
---@field second integer 默认秒

---@type TimeConfig
local default_time = {
  minute = 25,
  second = 90,
}

---@type vim.api.keyset.win_config
local default_window = {
  relative = "editor",
  anchor = "NE",
  row = 0,
  col = 0,
  width = 40,
  height = 15,
  border = "rounded",
  style = "minimal",
}

-- 设置默认配置
--- @class ObsessConfig
--- @field marker table
--- @field position string
--- @field window vim.api.keyset.win_config
--- @field flash FlashConfig
--- @field time TimeConfig

---@type ObsessConfig
M.defaults = {
  marker = default_marker,
  position = "center", -- 默认居中
  window = default_window,
  flash = default_flash,
  time = default_time,
}

-- 最终配置
---@type ObsessConfig
M.options = vim.deepcopy(M.defaults)

-- 插件状态
M.state = {
  buf = nil,
  win_id = nil,
  timer = false,
  running = false,
  tasks = {},
}

function M.get_project_info(bufnr, marker)
  bufnr = bufnr or 0
  -- 获取项目路径
  -- TODO: 用户配置格式说明
  local root_path = vim.fs.root(bufnr, marker) or vim.fn.getcwd()
  -- 获取项目名称
  local repo_name = vim.fs.basename(root_path)
  if not repo_name then
    return
  end

  local obsess_file = vim.fn.stdpath('data') .. '/obsess/' .. repo_name .. ".json"
  return repo_name, obsess_file
end

function M.setup(opts)
  -- 获取最终的用户配置选项
  M.options = vim.tbl_deep_extend("force", {}, M.defaults, opts or {})
  local repo_name, obsess_file = M.get_project_info(_, M.options.marker)
  M.obsess_file = obsess_file
end

return M
