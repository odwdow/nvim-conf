return {
  { "junegunn/fzf" },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "echasnovski/mini.icons" },
    config = function()
      require('config.fzf')
    end,
  }
}
