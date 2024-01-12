vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Make line numbers default
vim.wo.number = true
-- Show relative linenumbers
vim.wo.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true

-- Set highlight on search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- each ftplugin bundled with nvim messes with these settings
-- The need to go to an autocommand which runs his when opening a buffer
vim.opt.formatoptions:remove('c')
vim.opt.formatoptions:remove('r')
vim.opt.formatoptions:remove('o')

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true
vim.wo.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

