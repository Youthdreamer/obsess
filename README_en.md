# Obsess - NeoVim Focus Timer Plugin

### 🔗 Language: [中文](README.md) | [English](README_en.md)

Obsess is a NeoVim plugin designed to help developers improve focus. It provides a simple countdown timer and task management functionality, all displayed in a floating window with a clean and elegant interface, highly recommended for use with [LazyVim](https://www.lazyvim.org/).

---

## 🚀 Quick Start (LazyVim)

1. Install the plugin with default configuration by adding the following code to your `lazyvim.plugins`:

```lua
return {
    "Youthdreamer/obsess",
    cmd = { "ObsessTimer", "ObsessTimerSec", "ObsessTaskAdd" },
    opts = {}
}
```

2. **Bind shortcuts (recommended)**

```lua
vim.keymap.set("n", "<leader>ot", ":ObsessTimer<CR>", { desc = "Start Obsess Timer" })
```

---

## 🌟 Features

- **Countdown Timer**: Set a specific time to focus, with an alert when time is up
- **Task Management**: Add, delete, and mark tasks as completed to improve productivity
- **Floating Window**: Displayed in NeoVim's native floating window, clean and elegant
- **Window Flash Alert**: The window border flashes when time is up, providing a clear reminder
- **Highly Configurable**: Customize window position, size, border style, and more

---

## 🛠️ Installation (Recommended for LazyVim)

### LazyVim Configuration Example

```lua
return {
  "Youthdreamer/obsess",
  cmd = { "ObsessTimer", "ObsessTimerSec", "ObsessTaskAdd" },
  opts = {

    position = "center", -- Available position options: "center" | "top-right" | "top-left" | "bottom-left" | "bottom-right"
    window = {
      relative = "editor",
      width = 40,
      height = 15,
      border = "rounded",
      style = "minimal",
      title = "Obsess"
    },
    -- Notification settings for when the countdown finishes
    flash = {
      times = 6, -- Number of times the window flashes
      interval_ms = 300, -- Interval between each flash (in milliseconds)
    },
    time = {
      minute = 25, -- Default: 25 minutes
      second = 90, -- Default: 90 seconds
    },
  },
  -- Key mappings
  keys = {
    { "<leader>os", "<cmd>ObsessToggle<cr>", desc = "Toggle Window" },
    { "<leader>oc", "<cmd>ObsessClose<cr>", desc = "Close Window" },
    { "<leader>oo", "<cmd>ObsessTimer<cr>", desc = "Set Timer" },
    { "<leader>ol", "<cmd>ObsessTimerSec<cr>", desc = "Set Timer" },
    { "<leader>oa", "<cmd>ObsessTaskAdd<cr>", desc = "Add Task" },
    { "<leader>ot", "<cmd>ObsessTaskDone<cr>", desc = "Toggle Task Status" },
    { "<leader>od", "<cmd>ObsessTaskDel<cr>", desc = "Delete Task" },
    { "<leader>oe", "<cmd>ObsessTaskClear<cr>", desc = "Clear All Tasks" },
  },
}
```

### vim.pack Configuration Example

```lua
-- Install
vim.pack.add({
  { src = "https://github.com/Youthdreamer/obsess" },
})

require("obsess").setup({
  position = "center",
  window = {
    width  = 60,
    height = 15,
    title  = "Obsess",
  },
  flash = {
    times = 6,
    interval_ms = 300,
  }
})

vim.keymap.set("n", "<leader>os", "<cmd>ObsessToggle<CR>", { desc = "Toggle Window" })
vim.keymap.set("n", "<leader>oc", "<cmd>ObsessClose<CR>", { desc = "Close Window" })
vim.keymap.set("n", "<leader>oo", "<cmd>ObsessTimer<CR>", { desc = "Set Timer(m)" })
vim.keymap.set("n", "<leader>ol", "<cmd>ObsessTimerSec<CR>", { desc = "Set Timer(s)" })
vim.keymap.set("n", "<leader>oa", "<cmd>ObsessTaskAdd<CR>", { desc = "Add Task" })
vim.keymap.set("n", "<leader>ot", "<cmd>ObsessTaskDone<CR>", { desc = "Toggle Task Status" })
vim.keymap.set("n", "<leader>od", "<cmd>ObsessTaskDel<CR>", { desc = "Delete Task" })
vim.keymap.set("n", "<leader>oe", "<cmd>ObsessTaskClear<CR>", { desc = "Clear all Tasks" })
```

---

清空任务列表

## 📋 Command List (LazyVim Friendly)

Obsess provides a list of user commands that you can directly use in LazyVim:

| Command            | Description                     |
| ------------------ | ------------------------------- |
| `:ObsessToggle`    | Toggle Obsess window visibility |
| `:ObsessClose`     | Close Obsess window             |
| `:ObsessTimer`     | Set timer (in minutes)          |
| `:ObsessTimerSec`  | Set timer (in seconds)          |
| `:ObsessTaskAdd`   | Add a task                      |
| `:ObsessTaskDone`  | Mark task as done/undone        |
| `:ObsessTaskDel`   | Delete a task                   |
| `:ObsessTaskClear` | Clear all tasks                 |

You can also bind these commands to shortcuts in your LazyVim config, for example:

```lua
-- In your keymaps.lua
vim.keymap.set("n", "<leader>ot", ":ObsessTimer<CR>", { desc = "Start Obsess Timer" })
vim.keymap.set("n", "<leader>os", ":ObsessTaskAdd<CR>", { desc = "Add Obsess Task" })
```

---

## ⚙️ Configuration Options

You can customize Obsess behavior in the `setup()` function:

```lua
require("obsess").setup({
  position = "center",
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
    interval_ms = 300
  },
  time = {
    minute = 25,
    second = 90,
  },
})
```

---

## 🧪 API Interface (For LazyVim Custom Scripts)

You can also call Obsess APIs in your LazyVim Lua scripts:

```lua
-- Start a 1500-second countdown (25 minutes)
require("obsess").start(1500)

-- Set a 25-minute timer
require("obsess").timer(25)

-- Add a task "Complete Report"
require("obsess").tasks_add("Complete Report")

-- Toggle completion status of the first task
require("obsess").tasks_toggle(1)

-- Delete the first task
require("obsess").tasks_del(1)

-- Clear all tasks
require("obsess").tasks_clear()

-- Show or hide the Obsess window
require("obsess").toggle_win()

-- Close the Obsess window
require("obsess").close_win()
```

---

## 📦 Best Practices for LazyVim

1. **Bind Shortcuts**  
   Bind commonly used commands in `keymaps.lua` for quick access.

2. **Integrate with `which-key` Plugin**  
   Add `which-key` hints for Obsess commands to improve discoverability.

3. **Set Default Timer Duration**  
   Set a default time in the config to avoid inputting it every time.

4. **Auto Open Window**  
   Automatically open the window when calling `:ObsessTimer` for a better experience.

---

## 📜 License

This project is licensed under the MIT License.
