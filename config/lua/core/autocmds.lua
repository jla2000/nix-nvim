local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function() vim.lsp.inlay_hint(0, true) end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function() vim.lsp.inlay_hint(0, false) end,
})
