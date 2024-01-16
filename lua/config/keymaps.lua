--local wk = require("which-key")

-- move visual selected text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- down and up keeps the cursor in the center
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "J", "mzJ`z")

-- paste over deletion or something
vim.keymap.set("x", "<leader>p", [["_dP]])
-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
--vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

--Diagnostics
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Diagnostic float" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Diagnostic set loc list" })

--Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {desc="[f]loat [f]iles"})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {desc="[f]loat [g]rep"})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {desc="[f]loat [b]uffers}"})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {desc="[f]loat [h]elp tags"})

--Trouble 
--wk.register("x" ,"Trouble");
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
