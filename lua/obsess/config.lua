local M = {}

---@type string
M.obsess_file = vim.fn.stdpath('data') .. '/obsess/obsess.json'


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
--- @field position string
--- @field window vim.api.keyset.win_config
--- @field flash FlashConfig
--- @field time TimeConfig

---@type ObsessConfig
M.defaults = {
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

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", {}, M.defaults, opts or {})
end

return M
