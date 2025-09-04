-- C++ Clang config
clangd_cmd = "clangd"
if vim.env.LLVM_HOME then
	clangd_cmd = vim.env.LLVM_HOME .. "/bin/clangd"
end
vim.lsp.config("clangd", {
	cmd = {
		clangd_cmd,
		"--query-driver=** --compile-commands-dir=build --experimental-modules-support --background-index",
	},
	root_markers = { "compile_commands.json", "compile_flags.txt" },
	filetypes = { "c", "cpp" },
})

-- Java jdtls config
local function get_workspace_dir()
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	return vim.fn.stdpath("cache") .. "/jdtlsworkspaces/" .. project_name
end

local function add_commands()
	vim.cmd([[
    command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)
    command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)
    command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()
    command! -buffer JdtJol lua require('jdtls').jol()
    command! -buffer JdtBytecode lua require('jdtls').javap()
    command! -buffer JdtJshell lua require('jdtls').jshell()
    ]])
end


vim.lsp.enable({ "clangd", "jdtls","lua" })

vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
