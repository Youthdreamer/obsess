# Obsess - NeoVim 专注计时插件

### 🔗 Language: [中文](README.md) | [English](README_en.md)

![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)
![Neovim](https://img.shields.io/badge/Neovim-%4E%3D%200.9-green.svg)

Obsess 是一个为开发者设计的 NeoVim 专注计时插件。它将**倒计时定时器**与**任务管理**合二为一，所有内容显示在一个简洁美观的原生浮动窗口中，并且任务会自动持久化保存——重启 NeoVim 后依然保留。推荐使用 [lazy.nvim](https://github.com/folke/lazy.nvim) 插件管理器安装。

---

## ✨ 功能特性

- **⏱️ 倒计时定时器**：设置指定时间专注工作，倒计时结束后自动提醒
- **✅ 任务管理**：添加、删除、标记完成/未完成，一个轻量 TODO 面板
- **💾 任务持久化**：任务自动保存到本地 JSON 文件，重启不丢失
- **🪟 原生浮动窗口**：界面简洁美观，支持 5 个位置，随编辑器尺寸变化自动调整
- **✨ 边框闪烁提醒**：倒计时结束，窗口边框闪烁，醒目提醒
- **🎨 高度可配置**：窗口位置、大小、边框样式、闪烁次数、默认时长均可自定义

---

## 📋 环境要求

- **Neovim ≥ 0.9**

---

## 🚀 快速开始（lazy.nvim）

1. 在 lazy.nvim 的插件目录下新建 `lua/plugins/obsess.lua`，写入以下内容（不传 `opts` 也可以，插件会自动初始化）：

```lua
return {
  "Youthdreamer/obsess",
  cmd = {
    "ObsessToggle", "ObsessClose", "ObsessTimer", "ObsessTimerSec",
    "ObsessTaskAdd", "ObsessTaskDone", "ObsessTaskDel", "ObsessTaskClear", "ObsessTaskLoad",
  },
  opts = {},
}
```

2. 绑定快捷键（推荐）：

```lua
vim.keymap.set("n", "<leader>ot", ":ObsessTimer<CR>", { desc = "Start Obsess Timer" })
```

3. 在 Normal 模式下执行 `:ObsessTimer`，输入专注分钟数，回车即可开始倒计时。

---

## 🛠️ 安装方式

### lazy.nvim（推荐）

```lua
return {
  "Youthdreamer/obsess",
  cmd = {
    "ObsessToggle", "ObsessClose", "ObsessTimer", "ObsessTimerSec",
    "ObsessTaskAdd", "ObsessTaskDone", "ObsessTaskDel", "ObsessTaskClear", "ObsessTaskLoad",
  },
  opts = {
    position = "center", -- 可选：center | top-left | top-right | bottom-left | bottom-right
    window = {
      relative = "editor",
      width = 40,
      height = 15,
      border = "rounded",
      style = "minimal",
      title = "Obsess",
    },
    -- 倒计时结束后的闪烁提醒
    flash = {
      times = 6,        -- 闪烁次数
      interval_ms = 300 -- 每次间隔（毫秒）
    },
    -- 启动计时时的输入框默认值
    time = {
      minute = 25, -- 默认 25 分钟
      second = 90, -- 默认 90 秒
    },
  },
  -- 快捷键设置（见下方「推荐的快捷键」助记说明）
  keys = {
    { "<leader>ot", "<cmd>ObsessTimer<cr>", desc = "定时器（分钟）" },
    { "<leader>os", "<cmd>ObsessTimerSec<cr>", desc = "定时器（秒）" },
    { "<leader>ow", "<cmd>ObsessToggle<cr>", desc = "显示/隐藏窗口" },
    { "<leader>oc", "<cmd>ObsessClose<cr>", desc = "关闭窗口并停止计时" },
    { "<leader>oa", "<cmd>ObsessTaskAdd<cr>", desc = "添加任务" },
    { "<leader>ox", "<cmd>ObsessTaskDone<cr>", desc = "切换任务状态" },
    { "<leader>od", "<cmd>ObsessTaskDel<cr>", desc = "删除任务" },
    { "<leader>oe", "<cmd>ObsessTaskClear<cr>", desc = "清空任务" },
    { "<leader>ol", "<cmd>ObsessTaskLoad<cr>", desc = "刷新任务面板" },
  },
}
```

> **提示**：使用 LazyVim 发行版的用户，把上面的 spec 放入 `lazyvim.plugins` 即可，用法完全一致。

### vim.pack（Neovim 0.12+，实验性）

[vim.pack](https://github.com/neovim/neovim/pull/34009) 是 Neovim 0.12 引入的实验性内置插件管理器，无需第三方管理器：

```lua
-- 安装插件
vim.pack.add({
  { src = "https://github.com/Youthdreamer/obsess" },
})

-- 导入插件并配置
require("obsess").setup({
  position = "center",
  window = {
    width  = 60,
    height = 15,
    title  = "Obsess",
  },
  -- 倒计时结束后的闪烁提醒
  flash = {
    times = 6,
    interval_ms = 300,
  },
})

-- 快捷键设置
vim.keymap.set("n", "<leader>ot", "<cmd>ObsessTimer<CR>", { desc = "定时器（分钟）" })
vim.keymap.set("n", "<leader>os", "<cmd>ObsessTimerSec<CR>", { desc = "定时器（秒）" })
vim.keymap.set("n", "<leader>ow", "<cmd>ObsessToggle<CR>", { desc = "显示/隐藏窗口" })
vim.keymap.set("n", "<leader>oc", "<cmd>ObsessClose<CR>", { desc = "关闭窗口并停止计时" })
vim.keymap.set("n", "<leader>oa", "<cmd>ObsessTaskAdd<CR>", { desc = "添加任务" })
vim.keymap.set("n", "<leader>ox", "<cmd>ObsessTaskDone<CR>", { desc = "切换任务状态" })
vim.keymap.set("n", "<leader>od", "<cmd>ObsessTaskDel<CR>", { desc = "删除任务" })
vim.keymap.set("n", "<leader>oe", "<cmd>ObsessTaskClear<CR>", { desc = "清空任务" })
vim.keymap.set("n", "<leader>ol", "<cmd>ObsessTaskLoad<CR>", { desc = "刷新任务面板" })
```

> **提示**：使用其他插件管理器（vim-plug、packer.nvim 等）时，只需将 `lua/obsess` 加入 `runtimepath` 即可，配置方式与上面一致。

---

## 📋 命令一览

| 命令 | 说明 |
| --- | --- |
| `:ObsessToggle` | 显示/隐藏窗口（不销毁会话状态） |
| `:ObsessClose` | 完全关闭：停止计时、关闭窗口（任务保留，可继续添加） |
| `:ObsessTimer` | 启动倒计时，交互式输入分钟数（默认值来自 `time.minute`） |
| `:ObsessTimerSec` | 启动倒计时，交互式输入秒数（默认值来自 `time.second`） |
| `:ObsessTaskAdd` | 交互式添加任务 |
| `:ObsessTaskDone` | 选择任务并切换完成状态 |
| `:ObsessTaskDel` | 选择任务并删除 |
| `:ObsessTaskClear` | 确认后清空所有任务 |
| `:ObsessTaskLoad` | 加载/刷新任务面板显示 |

> 带输入的命令基于 `vim.ui.input` / `vim.ui.select` 实现，会自动适配你配置的 UI 插件（如 dressing.nvim）。

### 推荐的快捷键（助记）

| 快捷键 | 命令 | 助记 |
| --- | --- | --- |
| `<leader>ot` | `:ObsessTimer` | **t**imer — 定时器（分钟） |
| `<leader>os` | `:ObsessTimerSec` | **s**econds — 定时器（秒） |
| `<leader>ow` | `:ObsessToggle` | **w**indow — 显示/隐藏窗口 |
| `<leader>oc` | `:ObsessClose` | **c**lose — 关闭窗口并停止计时 |
| `<leader>oa` | `:ObsessTaskAdd` | **a**dd — 添加任务 |
| `<leader>ox` | `:ObsessTaskDone` | 勾选框 checkbox — 切换任务状态 |
| `<leader>od` | `:ObsessTaskDel` | **d**elete — 删除任务 |
| `<leader>oe` | `:ObsessTaskClear` | **e**rase — 清空任务 |
| `<leader>ol` | `:ObsessTaskLoad` | **l**oad — 加载/刷新任务面板 |

> 设计说明：前缀 `o` 取 Obsess 首字母，第二键直接对应命令的英文首字母（`t`=timer、`w`=window、`s`=seconds……勾选用 `x` 代表 checkbox），几乎无需记忆。如果你自己的配置中 `<leader>o` 前缀已被占用，整体替换前缀即可（如换成 `<leader>p`）。

---

## ⚙️ 配置选项

| 选项 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `position` | string | `"center"` | 窗口位置，可选：`center` / `top-left` / `top-right` / `bottom-left` / `bottom-right` |
| `window` | table | 见下 | 浮动窗口参数，透传给 `nvim_open_win` |
| `window.relative` | string | `"editor"` | 窗口相对基准 |
| `window.width` | number | `40` | 窗口宽度 |
| `window.height` | number | `15` | 窗口高度 |
| `window.border` | string | `"rounded"` | 边框样式（`rounded` / `single` / `double` / `none` 等） |
| `window.style` | string | `"minimal"` | 窗口样式 |
| `window.title` | string | 无 | 窗口标题（Neovim 0.9+ 支持） |
| `flash.times` | number | `6` | 倒计时结束后边框闪烁次数 |
| `flash.interval_ms` | number | `300` | 闪烁间隔（毫秒） |
| `time.minute` | number | `25` | `:ObsessTimer` 输入框默认分钟数 |
| `time.second` | number | `90` | `:ObsessTimerSec` 输入框默认秒数 |

完整示例：

```lua
require("obsess").setup({
  position = "top-right",
  window = {
    relative = "editor",
    width = 40,
    height = 15,
    border = "rounded",
    style = "minimal",
    title = "Obsess",
  },
  flash = {
    times = 6,
    interval_ms = 300,
  },
  time = {
    minute = 25,
    second = 90,
  },
})
```

---

## 🧪 API 参考

插件加载时会自动调用 `setup()`，之后即可在 Lua 脚本中调用以下 API：

| 方法 | 参数 | 说明 |
| --- | --- | --- |
| `setup(opts)` | table | 初始化/更新配置 |
| `start(seconds)` | number | 直接启动 `seconds` 秒倒计时 |
| `timer()` | — | 交互式输入分钟数启动倒计时（默认值来自 `time.minute`） |
| `tasks_add(text)` | string | 添加任务 |
| `tasks_toggle(index)` | number | 切换第 `index` 个任务的完成状态 |
| `tasks_del(index)` | number | 删除第 `index` 个任务 |
| `tasks_clear()` | — | 清空所有任务 |
| `tasks_load()` | — | 刷新任务面板显示 |
| `toggle_win()` | — | 显示/隐藏窗口 |
| `close_win()` | — | 完全关闭窗口并停止计时 |

示例：

```lua
-- 启动 1500 秒倒计时（25 分钟）
require("obsess").start(1500)

-- 交互式启动倒计时（输入分钟，默认 25）
require("obsess").timer()

-- 添加任务
require("obsess").tasks_add("完成报告")

-- 切换第 1 个任务的完成状态
require("obsess").tasks_toggle(1)

-- 删除第 1 个任务
require("obsess").tasks_del(1)

-- 清空所有任务
require("obsess").tasks_clear()

-- 刷新任务面板
require("obsess").tasks_load()

-- 显示/隐藏窗口
require("obsess").toggle_win()

-- 关闭窗口并停止计时
require("obsess").close_win()
```

---

## 💾 数据持久化

任务列表会自动保存到 `stdpath('data')/obsess/obsess.json`（Linux 下通常为 `~/.local/share/nvim/obsess/obsess.json`）：

- 插件初始化时自动读取该文件并恢复任务
- 添加、删除、切换状态、清空任务后，会将**整个内存列表**覆写回文件，无需手动保存
- 若 JSON 文件损坏，插件会提示错误并重置为空列表
- `:ObsessClose` 只停止计时并关闭窗口，不会清空任务，也不会写文件

---

## 📦 最佳实践

1. **配合 which-key**：安装 [which-key.nvim](https://github.com/folke/which-key.nvim) 后，`<leader>o` 分组会自动聚合上述快捷键；lazy.nvim 的 `keys` 配置开箱即与 which-key 兼容，给 `desc` 写清说明即可获得友好的提示。
2. **设置默认时长**：配置 `time.minute` / `time.second` 后，启动计时时直接回车即可使用默认值。
3. **当作轻量 TODO 使用**：任务跨会话保留，随时用 `:ObsessTaskAdd` 记录待办，`<leader>ox` 勾选完成。
4. **计时结束后的再次计时**：倒计时结束后（显示 `⏰ Time's up!`），如需重新计时，请先 `:ObsessClose` 重置再启动。

---

## ❓ 常见问题

- **再次启动计时器没反应？** 计时器运行中再次启动会提示 `Timer already running`。倒计时结束后如需重新计时，请先执行 `:ObsessClose`。
- **`:ObsessClose` 会删除我的任务吗？** 不会。它只停止计时并关闭窗口，内存与持久化文件中的任务都会保留，关闭后可以继续添加或勾选任务。
- **任务存在哪里？** 见上文「数据持久化」一节。

---

## 🤝 贡献

欢迎提交 [Issue](https://github.com/Youthdreamer/obsess/issues) 与 [PR](https://github.com/Youthdreamer/obsess/pulls)。

---

## 📜 许可证

本项目采用 **MIT** 许可证。
