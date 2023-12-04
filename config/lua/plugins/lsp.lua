-- Setup basic lsp_zero
local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })

  -- Enable inlay hints if provided
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(bufnr, true)
  end
end)

lsp_zero.format_on_save({
  servers = {
    ["lua_ls"] = { "lua" },
    ["nil_ls"] = { "nix" },
  },
})

-- Setup language servers
local lspconfig = require("lspconfig")

-- Rust
lspconfig.rust_analyzer.setup({})
-- C++
lspconfig.clangd.setup({ inlay_hints = true })
-- Nix
lspconfig.nil_ls.setup({})
-- Lua
require("neodev").setup({})
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      hint = {
        enable = true,
      },
    },
  },
})
