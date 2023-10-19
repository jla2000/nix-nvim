local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })
  print("Hello world")
end)

lsp_zero.format_on_save({
  servers = {
    ["lua_ls"] = { "lua" },
    ["rnix"] = { "nix" },
  }
})

require("lspconfig").clangd.setup({
  inlay_hints = true
})

require("lspconfig").rnix.setup({})

require("neodev").setup({})
require("lspconfig").lua_ls.setup({
  settings = {
    Lua = {
      hint = {
        enable = true
      }
    }
  }
})
