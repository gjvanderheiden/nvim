return {
	"nvim-treesitter/nvim-treesitter",
	build = function()
		require("nvim-treesitter.install").update({ with_sync = true })()
	end,
	config = function()
		require("nvim-treesitter").setup()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"python",
				"java",
				"xml",
				"json",
				"html",
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
      auto_install = true,
      modules={},
      ignore_install={}

		})
	end,
}
