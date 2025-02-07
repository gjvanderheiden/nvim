vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("JdtlsMainConfig", {}),
  callback = function(ev)
    local clients = vim.lsp.get_active_clients({ name = "jdtls", bufnr = ev.buf })
    if clients ~= nil and clients[1] ~= nil then
      require("jdtls.dap").setup_dap_main_class_configs()
    end
  end,
})
