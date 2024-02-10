local wk = require("which-key")

local function wk_leader_key(key, key_description)
	local mapping = {}
	mapping[key] = { name = key_description }
	wk.register(mapping, { prefix = "<leader>" })
end

local function navbuddy()
	require("nvim-navbuddy").open()
end

local function listClasses()
	local buffer = vim.api.nvim_get_current_buf()
	local params = { query = "*", sourceOnly = true }
	vim.lsp.buf_request(buffer, "java/searchSymbols", params, function(err, server_result, _, _)
		if err then
			vim.api.nvim_err_writeln("Error when finding workspace symbols: " .. err.message)
			return
		end
		local pickers = require("telescope.pickers")
		local locations = vim.lsp.util.symbols_to_items(server_result or {}, buffer) or {}
		if locations == nil then
			-- error message already printed in `utils.filter_symbols`
			return
		end

		if vim.tbl_isempty(locations) then
			require("telescope.utils").notify("builtin.lsp_workspace_symbols", {
				msg = "No results from workspace/symbol. Maybe try a different query: "
					.. "'Telescope lsp_workspace_symbols query=example'",
				level = "INFO",
			})
			return
		end
		local opts = {}

		opts.ignore_filename = vim.F.if_nil(opts.ignore_filename, false)

		local conf = require("telescope.config").values
		local finders = require("telescope.finders")

		local make_entry = require("telescope.make_entry")
		pickers
			.new(opts, {
				prompt_title = "Workspace Classes",
				finder = finders.new_table({
					results = locations,
					entry_maker = opts.entry_maker or make_entry.gen_from_lsp_symbols(opts),
				}),
				previewer = conf.qflist_previewer(opts),
				sorter = conf.prefilter_sorter({
					tag = "symbol_type",
					sorter = conf.generic_sorter(opts),
				}),
			})
			:find()
	end)
end

vim.keymap.set("n", "<leader>a", listClasses)
vim.keymap.set("n", "<leader>n", navbuddy, { desc = "Navbuddy" })
-- move visual selected text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- down and up keeps the cursor in the center
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "J", "mzJ`z")

-- paste over deletion or something
vim.keymap.set("x", "<leader>p", [["_dP]])
-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
--vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

--Diagnostics
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Diagnostic float" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic set loc list" })

--Telescope
wk_leader_key("s", "[S]earch")
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [f]iles" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch [g]rep" })
vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [b]uffers}" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [h]elp tags" })

--Trouble
wk_leader_key("x", "Trouble")
local trouble = require("trouble")
vim.keymap.set("n", "<leader>xx", trouble.toggle, { desc = "Toggle trouble" })
vim.keymap.set("n", "<leader>xw", function()
	trouble.toggle("workspace_diagnostics")
end, { desc = "Workspace diagnostics" })
vim.keymap.set("n", "<leader>xd", function()
	trouble.toggle("document_diagnostics")
end, { desc = "Document diagnostics" })
vim.keymap.set("n", "<leader>xq", function()
	trouble.toggle("quickfix")
end, { desc = "Quickfix" })
vim.keymap.set("n", "<leader>xl", function()
	trouble.toggle("loclist")
end, { desc = "Loc list" })
vim.keymap.set("n", "gR", function()
	trouble.toggle("lsp_references")
end, { desc = "LSP references (trsble)" })

wk_leader_key("d", "[D]ebug")
vim.keymap.set("n", "<Leader>dc", function()
	require("dap").continue()
end, {desc = "[C]ontinue"})
vim.keymap.set("n", "<Leader>dt", function()
	require("dap").terminate()
end, {desc = "[T]erminate"})
vim.keymap.set("n", "<F5>", function()
	require("dap").continue()
end, {desc = "Continue"})
vim.keymap.set("n", "<F10>", function()
	require("dap").step_over()
end,{desc = "Step over"})
vim.keymap.set("n", "<F11>", function()
	require("dap").step_into()
end,{desc = "Step into"})
vim.keymap.set("n", "<F12>", function()
	require("dap").step_out()
end,{desc = "Step out"})
vim.keymap.set("n", "<Leader>db", function()
	require("dap").toggle_breakpoint()
end,{desc = "Toggle [b]reakpoint"})
vim.keymap.set("n", "<Leader>dr", function()
	require("dap").repl.open()
end,{desc = "Open [r]epl"})
vim.keymap.set("n", "<Leader>dl", function()
	require("dap").run_last()
end,{desc = "Run [l]ast"})
vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
	require("dap.ui.widgets").hover()
end,{desc = "hover"})
vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
	require("dap.ui.widgets").preview()
end,{desc = "preview"})
vim.keymap.set("n", "<Leader>df", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.frames)
end,{desc = "float frames"})
vim.keymap.set("n", "<Leader>ds", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end,{desc = "float scopes widgets"})
vim.keymap.set("n", "<Leader>du", function()
	require("dapui").toggle()
end,{desc = "Toggle [U]I"})
