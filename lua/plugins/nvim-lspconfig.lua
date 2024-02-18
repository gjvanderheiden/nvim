return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"folke/neodev.nvim",
		"hrsh7th/nvim-cmp",
		"j-hui/fidget.nvim",
		"SmiteshP/nvim-navbuddy",
	},
	config = function()
		print("config lspconfig")
		require("fidget").setup({})
		require("neodev").setup({})
		local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local lua_ls_setup = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
			},
			capabilities = capabilities,
		}
		lspconfig.lua_ls.setup({ settings = lua_ls_setup })
    lspconfig.clangd.setup({cmd={"/home/gertjan/.local/share/clang/bin/clangd"}})
    lspconfig.pyright.setup({})
	end,
}
