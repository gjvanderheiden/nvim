-- move visual selected text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--Diagnostics
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Diagnostic float" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Diagnostic set loc list" })

--Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

--Trouble 
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
end, { desc = "LSP references (trouble)" })
