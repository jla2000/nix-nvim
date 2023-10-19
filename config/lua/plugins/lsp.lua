require("neodev").setup({})

local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })
  vim.lsp.inlay_hint(bufnr, true)
end)

lsp_zero.format_on_save({
  servers = {
    ["lua_ls"] = { "lua" },
    ["rnix"] = { "nix" },
  }
})

lsp_zero.setup_servers({ "rnix" })

require("lspconfig").lua_ls.setup({
  settings = {
    Lua = {
      hint = {
        enable = true
      }
    }
  }
})
