
local function get_bundles()
	local jdtls_bundles = "/opt/jdtls-bundles"
	local bundle_dirs = vim.split(vim.fn.glob(jdtls_bundles .. "/*/"), "\n")

	local bundles = {}
	for _, bundle_dir in pairs(bundle_dirs) do
    local jars = vim.split(vim.fn.glob(bundle_dir .. "*.jar", true), '\n')
    vim.list_extend(bundles, jars)
	end
  return bundles
end

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

local simple_config = function()
	local config = {
		cmd = { "jdtls", "-data", get_workspace_dir() },
		root_dir = vim.fs.dirname(vim.fs.find({ "pom.xml", "gradlew", ".git", "mvnw" }, { upward = true })[1]),
		init_options = {
			bundles = get_bundles() ,
		},
	}
	require("jdtls").start_or_attach(config)
  add_commands()
end


vim.api.nvim_create_autocmd("FileType", { pattern = "java", callback = simple_config })
