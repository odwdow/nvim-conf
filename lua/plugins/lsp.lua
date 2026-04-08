return {
  {
    "neovim/nvim-lspconfig"
  },
  {
    "williamboman/mason.nvim",
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim"
    },
    config = function()
      require('config.lsp')
    end,
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      -- options
    },
  },
  {
    "stevearc/conform.nvim",
    dependencies = {},
    config = function()
      require('config.conform')
    end,
  },
}
