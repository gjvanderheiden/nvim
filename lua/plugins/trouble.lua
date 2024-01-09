return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- Lua
		vim.keymap.set("n", "<leader>xx", function()
			require("trouble").toggle()
		end, { desc = "Toggle trouble" })
		vim.keymap.set("n", "<leader>xw", function()
			require("trouble").toggle("workspace_diagnostics")
		end, { desc = "Workspace diagnostics" })
		vim.keymap.set("n", "<leader>xd", function()
			require("trouble").toggle("document_diagnostics")
		end, { desc = "Document diagnostics" })
		vim.keymap.set("n", "<leader>xq", function()
			require("trouble").toggle("quickfix")
		end, { desc = "Quickfix" })
		vim.keymap.set("n", "<leader>xl", function()
			require("trouble").toggle("loclist")
		end, { desc = "Loc list" })
		vim.keymap.set("n", "gR", function()
			require("trouble").toggle("lsp_references")
		end, { desc = "LSP references (trouble)" })
	end,
}
