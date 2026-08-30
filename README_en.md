# Obsess - NeoVim Focus Timer Plugin

### 🔗 Language: [中文](README.md) | [English](README_en.md)

![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)
![Neovim](https://img.shields.io/badge/Neovim-%3E%3D%200.9-green.svg)

Obsess is a focus timer plugin for NeoVim, designed for developers. It combines a **countdown timer** with **task management**, all displayed in a clean native floating window. Your tasks are automatically persisted to a local JSON file, so they survive restarts. Recommended installation via the [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager.

---

## ✨ Features

- **⏱️ Countdown Timer**: Set a focus session and get reminded automatically when time is up
- **✅ Task Management**: Add, delete, and toggle tasks done/undone — a lightweight TODO panel
- **💾 Task Persistence**: Tasks are auto-saved to a local JSON file and survive restarts
- **🪟 Native Floating Window**: Clean UI with 5 position presets, auto-repositioned on editor resize
- **✨ Border Flash Alert**: The window border flashes when the countdown finishes
- **🎨 Highly Configurable**: Window position, size, border style, flash behavior, and default durations

---

## 📋 Requirements

- **Neovim ≥ 0.9**

---

## 🚀 Quick Start (lazy.nvim)

1. Create `lua/plugins/obsess.lua` in your lazy.nvim plugin directory with the following content. It works out of the box — `opts` is optional (the plugin auto-initializes):

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

2. Bind a shortcut (recommended):

```lua
vim.keymap.set("n", "<leader>ot", ":ObsessTimer<CR>", { desc = "Start Obsess Timer" })
```

3. Run `:ObsessTimer` in Normal mode, enter the focus duration in minutes, and press Enter to start.

---

## 🛠️ Installation

### lazy.nvim (Recommended)

```lua
return {
  "Youthdreamer/obsess",
  cmd = {
    "ObsessToggle", "ObsessClose", "ObsessTimer", "ObsessTimerSec",
    "ObsessTaskAdd", "ObsessTaskDone", "ObsessTaskDel", "ObsessTaskClear", "ObsessTaskLoad",
  },
  opts = {
    position = "center", -- Available: center | top-left | top-right | bottom-left | bottom-right
    window = {
      relative = "editor",
      width = 40,
      height = 15,
      border = "rounded",
      style = "minimal",
      title = "Obsess",
    },
    -- Flash alert when the countdown finishes
    flash = {
      times = 6,        -- Number of flashes
      interval_ms = 300 -- Interval between flashes (ms)
    },
    -- Default values for the timer input prompt
    time = {
      minute = 25, -- Default: 25 minutes
      second = 90, -- Default: 90 seconds
    },
  },
  -- Key mappings (see the "Recommended Keymaps" table below for mnemonics)
  keys = {
    { "<leader>ot", "<cmd>ObsessTimer<cr>", desc = "Timer (Minutes)" },
    { "<leader>os", "<cmd>ObsessTimerSec<cr>", desc = "Timer (Seconds)" },
    { "<leader>ow", "<cmd>ObsessToggle<cr>", desc = "Show/Hide Window" },
    { "<leader>oc", "<cmd>ObsessClose<cr>", desc = "Close Window & Stop Timer" },
    { "<leader>oa", "<cmd>ObsessTaskAdd<cr>", desc = "Add Task" },
    { "<leader>ox", "<cmd>ObsessTaskDone<cr>", desc = "Toggle Task Status" },
    { "<leader>od", "<cmd>ObsessTaskDel<cr>", desc = "Delete Task" },
    { "<leader>oe", "<cmd>ObsessTaskClear<cr>", desc = "Clear All Tasks" },
    { "<leader>ol", "<cmd>ObsessTaskLoad<cr>", desc = "Refresh Task Panel" },
  },
}
```

> **Note**: If you use the LazyVim distribution, just put the spec above into your `lazyvim.plugins` — everything works the same.

### vim.pack (Neovim 0.12+, Experimental)

[vim.pack](https://github.com/neovim/neovim/pull/34009) is the experimental built-in plugin manager introduced in Neovim 0.12 — no third-party manager required:

```lua
-- Install
vim.pack.add({
  { src = "https://github.com/Youthdreamer/obsess" },
})

-- Configure
require("obsess").setup({
  position = "center",
  window = {
    width  = 60,
    height = 15,
    title  = "Obsess",
  },
  -- Flash alert when the countdown finishes
  flash = {
    times = 6,
    interval_ms = 300,
  },
})

-- Key mappings
vim.keymap.set("n", "<leader>ot", "<cmd>ObsessTimer<CR>", { desc = "Timer (Minutes)" })
vim.keymap.set("n", "<leader>os", "<cmd>ObsessTimerSec<CR>", { desc = "Timer (Seconds)" })
vim.keymap.set("n", "<leader>ow", "<cmd>ObsessToggle<CR>", { desc = "Show/Hide Window" })
vim.keymap.set("n", "<leader>oc", "<cmd>ObsessClose<CR>", { desc = "Close Window & Stop Timer" })
vim.keymap.set("n", "<leader>oa", "<cmd>ObsessTaskAdd<CR>", { desc = "Add Task" })
vim.keymap.set("n", "<leader>ox", "<cmd>ObsessTaskDone<CR>", { desc = "Toggle Task Status" })
vim.keymap.set("n", "<leader>od", "<cmd>ObsessTaskDel<CR>", { desc = "Delete Task" })
vim.keymap.set("n", "<leader>oe", "<cmd>ObsessTaskClear<CR>", { desc = "Clear All Tasks" })
vim.keymap.set("n", "<leader>ol", "<cmd>ObsessTaskLoad<CR>", { desc = "Refresh Task Panel" })
```

> **Note**: With other plugin managers (vim-plug, packer.nvim, etc.), just add `lua/obsess` to your `runtimepath`; the configuration is the same as above.

---

## 📋 Command List

| Command            | Description                                    |
| ------------------ | ---------------------------------------------- |
| `:ObsessToggle`    | Show/hide the window (session state is kept)   |
| `:ObsessClose`     | Fully close: stop timer, close window (tasks are kept — you can keep adding) |
| `:ObsessTimer`     | Start a countdown; prompts for minutes (default from `time.minute`) |
| `:ObsessTimerSec`  | Start a countdown; prompts for seconds (default from `time.second`) |
| `:ObsessTaskAdd`   | Add a task interactively                       |
| `:ObsessTaskDone`  | Select a task and toggle its done status       |
| `:ObsessTaskDel`   | Select a task and delete it                    |
| `:ObsessTaskClear` | Clear all tasks after confirmation             |
| `:ObsessTaskLoad`  | Load/refresh the task panel display            |

> Interactive commands are built on `vim.ui.input` / `vim.ui.select`, so they automatically integrate with UI plugins like dressing.nvim.

### Recommended Keymaps (Mnemonics)

| Keymap     | Command             | Mnemonic                                     |
| ---------- | ------------------- | -------------------------------------------- |
| `<leader>ot` | `:ObsessTimer`    | **t**imer — timer (minutes)                  |
| `<leader>os` | `:ObsessTimerSec` | **s**econds — timer (seconds)                |
| `<leader>ow` | `:ObsessToggle`   | **w**indow — show/hide window                |
| `<leader>oc` | `:ObsessClose`    | **c**lose — close window & stop timer        |
| `<leader>oa` | `:ObsessTaskAdd`  | **a**dd — add a task                         |
| `<leader>ox` | `:ObsessTaskDone` | checkbo**x** — toggle task done status       |
| `<leader>od` | `:ObsessTaskDel`  | **d**elete — delete a task                   |
| `<leader>oe` | `:ObsessTaskClear`| **e**rase — clear all tasks                  |
| `<leader>ol` | `:ObsessTaskLoad` | **l**oad — load/refresh the task panel       |

> Design note: the prefix `o` stands for Obsess, and each second key is the first letter of the related command (`t`=timer, `w`=window, `s`=seconds, ... with `x` for checkbox), so there is almost nothing to memorize. If `<leader>o` is already taken in your own config, simply replace the prefix (e.g. `<leader>p`).

---

## ⚙️ Configuration Options

| Option           | Type   | Default      | Description                                  |
| ---------------- | ------ | ------------ | -------------------------------------------- |
| `position`       | string | `"center"`   | Window position: `center` / `top-left` / `top-right` / `bottom-left` / `bottom-right` |
| `window`         | table  | see below    | Floating window config, passed through to `nvim_open_win` |
| `window.relative`| string | `"editor"`   | Window relative base                         |
| `window.width`   | number | `40`         | Window width                                 |
| `window.height`  | number | `15`         | Window height                                |
| `window.border`  | string | `"rounded"`  | Border style (`rounded` / `single` / `double` / `none`, etc.) |
| `window.style`   | string | `"minimal"`  | Window style                                 |
| `window.title`   | string | none         | Window title (Neovim 0.9+)                   |
| `flash.times`    | number | `6`          | Number of border flashes when time is up     |
| `flash.interval_ms` | number | `300`     | Flash interval (ms)                          |
| `time.minute`    | number | `25`         | Default minutes for `:ObsessTimer` prompt    |
| `time.second`    | number | `90`         | Default seconds for `:ObsessTimerSec` prompt |

Full example:

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

## 🧪 API Reference

`setup()` is called automatically when the plugin loads. You can then use these APIs from Lua scripts:

| Method             | Argument | Description                                      |
| ------------------ | -------- | ------------------------------------------------ |
| `setup(opts)`      | table    | Initialize/update configuration                  |
| `start(seconds)`   | number   | Start a countdown of `seconds` directly          |
| `timer()`          | —        | Interactive countdown in minutes (default from `time.minute`) |
| `tasks_add(text)`  | string   | Add a task                                       |
| `tasks_toggle(index)` | number | Toggle the done status of task `index`        |
| `tasks_del(index)` | number   | Delete task `index`                              |
| `tasks_clear()`    | —        | Clear all tasks                                  |
| `tasks_load()`     | —        | Refresh the task panel display                   |
| `toggle_win()`     | —        | Show/hide the window                             |
| `close_win()`      | —        | Fully close the window and stop the timer        |

Example:

```lua
-- Start a 1500-second countdown (25 minutes)
require("obsess").start(1500)

-- Interactive countdown (prompts for minutes, default 25)
require("obsess").timer()

-- Add a task
require("obsess").tasks_add("Complete Report")

-- Toggle the done status of task 1
require("obsess").tasks_toggle(1)

-- Delete task 1
require("obsess").tasks_del(1)

-- Clear all tasks
require("obsess").tasks_clear()

-- Refresh the task panel
require("obsess").tasks_load()

-- Show/hide the window
require("obsess").toggle_win()

-- Close the window and stop the timer
require("obsess").close_win()
```

---

## 💾 Data Persistence

Your tasks are automatically saved to `stdpath('data')/obsess/obsess.json` (usually `~/.local/share/nvim/obsess/obsess.json` on Linux):

- Tasks are loaded and restored automatically when the plugin initializes
- Adding, deleting, toggling, or clearing tasks writes the **entire in-memory list** back to the file automatically — no manual saving needed
- If the JSON file is corrupted, the plugin reports an error and resets to an empty list
- `:ObsessClose` only stops the timer and closes the window — it never clears tasks or writes to the file

---

## 📦 Best Practices

1. **Pair with which-key**: Install [which-key.nvim](https://github.com/folke/which-key.nvim) and the `<leader>o` group will automatically aggregate the keymaps above; lazy.nvim's `keys` config works with which-key out of the box — write clear `desc` strings for friendly hints.
2. **Set default durations**: Configure `time.minute` / `time.second`, then just press Enter at the prompt to use the defaults.
3. **Use it as a lightweight TODO**: Tasks persist across sessions — jot down todos with `:ObsessTaskAdd` and check them off with `<leader>ox`.
4. **Restarting after a finished timer**: Once the countdown ends (showing `⏰ Time's up!`), run `:ObsessClose` first to reset before starting a new one.

---

## ❓ FAQ

- **Nothing happens when I start the timer again?** Starting while a timer is running shows `Timer already running`. After a countdown finishes, run `:ObsessClose` before starting a new one.
- **Does `:ObsessClose` delete my tasks?** No. It only stops the timer and closes the window; tasks are kept both in memory and in the persistence file, so you can keep adding or toggling tasks afterwards.
- **Where are my tasks stored?** See the "Data Persistence" section above.

---

## 🤝 Contributing

Issues and pull requests are welcome on [GitHub](https://github.com/Youthdreamer/obsess).

---

## 📜 License

This project is licensed under the **MIT** License.
