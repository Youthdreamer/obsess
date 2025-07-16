local config = require("obsess.config")
local timer = require("obsess.timer")
local ui = require("obsess.ui")

local M = {}

M.setup = function()
	-- 注册命令外部调用
	vim.api.nvim_create_user_command("ObsessToggle", function()
		ui.toggle_win()
	end, { desc = "Toogle Obsess window" })

	vim.api.nvim_create_user_command("ObsessClose", function()
		ui.close()
	end, { desc = "Close Obsess window" })

	vim.api.nvim_create_user_command("ObsessTimer", function()
		timer.timer()
	end, { desc = "Use Obsess timer" })

	vim.api.nvim_create_user_command("ObsessTimerSec", function()
		timer.timer_sec()
	end, { desc = "Use Obsess timer(second)" })

	vim.api.nvim_create_user_command("ObsessTaskAdd", function()
		vim.ui.input({ prompt = "Enter task: " }, function(input)
			if input and input ~= "" then
				require("obsess.tasks").add(input)
			else
				vim.notify("No task entered", vim.log.levels.WARN)
			end
		end)
	end, { desc = "Add a task interactively" })

	vim.api.nvim_create_user_command("ObsessTaskDone", function()
		local tasks = config.state.tasks
		if #tasks == 0 then
			vim.notify("No tasks to toggle", vim.log.levels.WARN)
			return
		end
		local items = {}
		for i, task in ipairs(tasks) do
			local mark = task.done and "✓" or " "
			table.insert(items, string.format("[%s] %d. %s", mark, i, task.text))
		end
		vim.ui.select(items, { prompt = "Select task to toggle" }, function(_, idx)
			if idx then
				require("obsess.tasks").toggle_done(idx)
			end
		end)
	end, { desc = "Toggle task done interactively" })

	vim.api.nvim_create_user_command("ObsessTaskDel", function()
		local tasks = config.state.tasks
		if #tasks == 0 then
			vim.notify("No tasks to delete", vim.log.levels.WARN)
			return
		end
		local items = {}
		for i, task in ipairs(tasks) do
			local mark = task.done and "✓" or " "
			table.insert(items, string.format("[%s] %d. %s", mark, i, task.text))
		end
		vim.ui.select(items, { prompt = "Select task to delete" }, function(_, idx)
			if idx then
				require("obsess.tasks").remove(idx)
			end
		end)
	end, { desc = "Delete task interactively" })

	vim.api.nvim_create_user_command("ObsessTaskClear", function()
		vim.ui.select({ "No", "Yes" }, { prompt = "Clear all tasks?" }, function(choice)
			if choice == "Yes" then
				require("obsess.tasks").clear()
			end
		end)
	end, { desc = "Clear all tasks with confirm" })
end

return M
