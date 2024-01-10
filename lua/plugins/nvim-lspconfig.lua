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
		-- Setup language servers.
		local lspconfig = require("lspconfig")
		-- Server-specific settings. See `:help lspconfig-setup`
		--
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local lua_ls_setup = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
			},
			capabilities = capabilities,
		}
		--lspconfig.lua_ls.setup {settings = lua_ls_setup}
		lspconfig.lua_ls.setup({ settings = lua_ls_setup })
		--lspconfig.jdtls.setup({settings = {capabilities = capabilities}});
		-- Global mappings.
		-- See `:help vim.diagnostic.*` for documentation on any of the below functions
		vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Diagnostic float" })
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic" })
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })
		vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Diagnostic set loc list" })

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go to declaration" })
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover" })
				vim.keymap.set(
					"n",
					"gi",
					vim.lsp.buf.implementation,
					{ buffer = ev.buf, desc = "Go to implementation" }
				)
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Signature help" })
				vim.keymap.set(
					"n",
					"<space>wa",
					vim.lsp.buf.add_workspace_folder,
					{ buffer = ev.buf, desc = "Add workspace folder" }
				)
				vim.keymap.set(
					"n",
					"<space>wr",
					vim.lsp.buf.remove_workspace_folder,
					{ buffer = ev.buf, desc = "Remove workspace folder" }
				)
				vim.keymap.set("n", "<space>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, { buffer = ev.buf, desc = "List workspace folders" })
				vim.keymap.set(
					"n",
					"<space>D",
					vim.lsp.buf.type_definition,
					{ buffer = ev.buf, desc = "Type Definition" }
				)
				vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
				vim.keymap.set(
					{ "n", "v" },
					"<space>ca",
					vim.lsp.buf.code_action,
					{ buffer = ev.buf, desc = "Code action" }
				)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "References" })
				vim.keymap.set("n", "<space>cf", function()
					vim.lsp.buf.format({ async = true })
				end, { buffer = ev.buf, desc = "Format" })
			end,
		})
	end,
}
