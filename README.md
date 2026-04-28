# Obsess - NeoVim 专注计时插件

### 🔗 Language: [中文](README.md) | [English](README_en.md)

Obsess 是一个 NeoVim 插件。它提供了一个简单的倒计时定时器和任务管理功能，所有内容显示在一个浮动窗口中，界面简洁美观，推荐在 [LazyVim](https://www.lazyvim.org/) 上使用。

---

## 🚀 快速开始(LazyVim)

1. 安装插件使用默认配置，在 `lazyvim.plugins` 中添加以下代码

```lua
return {
    "Youthdreamer/obsess",
    cmd = { "ObsessTimer", "ObsessTimerSec", "ObsessTaskAdd" },
    opts = {}
}
```

2.绑定快捷键（推荐）

```lua
vim.keymap.set("n", "<leader>ot", ":ObsessTimer<CR>", { desc = "Start Obsess Timer" })
```

## 🌟 功能特性

- **倒计时定时器**：设置指定时间，专注工作，时间到自动提醒
- **任务管理**：添加、删除、标记完成任务，提升任务管理效率
- **浮动窗口**：使用 NeoVim 原生浮动窗口展示，界面简洁美观
- **窗口闪烁提醒**：时间到后窗口边框闪烁，醒目提醒
- **高度可配置**：支持自定义窗口位置、大小、边框样式等

---

## 🛠️ 安装方式（LazyVim 推荐）

### LazyVim 配置方式(范例)

```lua
return {
  "Youthdreamer/obsess",
  cmd = { "ObsessTimer", "ObsessTimerSec", "ObsessTaskAdd" },
  opts = {
    position = "center", -- 可选位置参数option: "center" | "top-right" | "top-left" | "bottom-left" | "bottom-right"
    window = {
      relative = "editor",
      width = 40,
      height = 15,
      border = "rounded",
      style = "minimal",
      title = "Obsess"
    },
    -- 倒计时结束后的弹窗提醒设置
    flash = {
      times = 6, -- 闪烁次数
      interval_ms = 300, -- 每次间隔时间
    },
    time = {
      minute = 25, -- 默认25分钟
      second = 90, -- 默认90秒
    },
  },
  -- 快捷键设置
  keys = {
    { "<leader>os", "<cmd>ObsessToggle<cr>", desc = "切换窗口" },
    { "<leader>oc", "<cmd>ObsessClose<cr>", desc = "注销" },
    { "<leader>oo", "<cmd>ObsessTimer<cr>", desc = "设置定时器" },
    { "<leader>ol", "<cmd>ObsessTimerSec<cr>", desc = "设置定时器" },
    { "<leader>oa", "<cmd>ObsessTaskAdd<cr>", desc = "添加任务" },
    { "<leader>ot", "<cmd>ObsessTaskDone<cr>", desc = "切换任务状态" },
    { "<leader>od", "<cmd>ObsessTaskDel<cr>", desc = "删除任务" },
    { "<leader>oe", "<cmd>ObsessTaskClear<cr>", desc = "清空任务列表" },
  },
}
```

---

## 📋 命令一览（支持 LazyVim 快捷调用）

Obsess 提供了一系列用户命令，你可以直接在 LazyVim 中使用：

| 命令               | 说明                      |
| ------------------ | ------------------------- |
| `:ObsessToggle`    | 切换 Obsess 窗口显示/隐藏 |
| `:ObsessClose`     | 注销 Obsess 窗口          |
| `:ObsessTimer`     | 设置倒计时（分钟）        |
| `:ObsessTimerSec`  | 设置倒计时（秒）          |
| `:ObsessTaskAdd`   | 添加任务                  |
| `:ObsessTaskDone`  | 标记任务完成/未完成       |
| `:ObsessTaskDel`   | 删除任务                  |
| `:ObsessTaskClear` | 清空所有任务              |

你也可以在 LazyVim 的快捷键配置中绑定这些命令，例如：

```lua
-- 在你的 keymaps.lua 中添加
vim.keymap.set("n", "<leader>ot", ":ObsessTimer<CR>", { desc = "Start Obsess Timer" })
vim.keymap.set("n", "<leader>os", ":ObsessTaskAdd<CR>", { desc = "Add Obsess Task" })
```

---

## ⚙️ 配置选项

你可以在 `setup()` 函数中自定义 Obsess 的行为：

```lua
require("obsess").setup({
  position = "center",
  window = {
    relative = "editor",
    width = 40,
    height = 15,
    border = "rounded",
    style = "minimal",
    title = "Obsess"
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

## 🧪 API 接口（适用于 LazyVim 自定义脚本）

你也可以在 LazyVim 的 Lua 脚本中调用 Obsess 的 API：

```lua
-- 启动 1500 秒倒计时（25 分钟）
require("obsess").start(1500)

-- 使用分钟设置倒计时（例如：25 分钟）
require("obsess").timer(25)

-- 添加任务 "完成报告"
require("obsess").tasks_add("完成报告")

-- 标记第一个任务为完成/未完成
require("obsess").tasks_toggle(1)

-- 删除第一个任务
require("obsess").tasks_del(1)

-- 清空所有任务
require("obsess").tasks_clear()

-- 显示或隐藏 Obsess 窗口
require("obsess").toggle_win()

-- 关闭 Obsess 窗口
require("obsess").close_win()
```

---

## 📦 LazyVim 最佳实践建议

1. **绑定快捷键**  
   在 `keymaps.lua` 中绑定常用命令，快速调用。

2. **结合 `which-key` 插件**  
   为 Obsess 命令添加 `which-key` 快捷提示，方便快捷操作。

3. **设置默认倒计时时间**  
   在配置中设置 `default` 时间，避免每次输入。

4. **自动打开窗口**  
   可以在 `ObsessTimer` 命令中自动打开窗口，提升体验。

---

## 📜 许可证

本项目采用 MIT 许可证。
