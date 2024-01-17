local function clang_extententions_config()
  require("clangd_extensions.inlay_hints").setup_autocmd()
  require("clangd_extensions.inlay_hints").set_inlay_hints()
end

vim.api.nvim_create_autocmd(
  "FileType",
  { pattern = { "c", "cpp", "objc", "objcpp", "cuda", "proto"}, callback = clang_extententions_config }
)
