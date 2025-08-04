vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.lsp.config.clangd = {
  cmd = { vim.env.LLVM_HOME .. '/bin/clangd', '--query-driver=** --compile-commands-dir=build --experimental-modules-support --background-index' },
  root_markers = { 'compile_commands.json', 'compile_flags.txt' },
  filetypes = { 'c', 'cpp' },
}

vim.lsp.enable({'clangd'})

vim.diagnostic.config({ virtual_text = true })
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})
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

