require("conform").setup({
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    jsonc = { "prettierd" },
    terraform = { "terraform-ls" },
    rust = { "rustfmt", lsp_format = "fallback" },
  },
  formatters = {},
})
