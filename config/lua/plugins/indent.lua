require("ibl").setup({
  indent = {
    char = "│",
    tab_char = "│",
  },
  scope = {
    enabled = false
  },
})
require("mini.indentscope").setup({
  symbol = "│",
})
