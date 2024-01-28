return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.xmlformat.with({
        extra_args = { "--blanks" },
    }),
        null_ls.builtins.diagnostics.tidy,
			},
		})
	end,
}
