require("codecompanion").setup({
  display = {
    action_palette = {
      width = 95,
      height = 10,
      prompt = "[> ",
      provider = "mini_pick",
      opts = {
        show_default_actions = true,
        show_default_prompt_library = true,
      },
    },
  },
  strategies = {
    -- Change the default chat adapter
    chat = {
      adapter = 'gemma3',
      inline = 'gemma3',
    },
  },
  adapters = {
    gemma3 = function()
      return require('codecompanion.adapters').extend('ollama', {
        name = 'gemma', -- Give this adapter a different name to differentiate it from the default ollama adapter
        schema = {
          model = {
            default = 'gemma3:1b',
          },
        },
      })
    end,
  },
  opts = {
    log_level = 'DEBUG',
  },
})

vim.keymap.set('n', '<leader>ca', '<cmd>CodeCompanionActions<CR>')
vim.keymap.set('v', '<leader>ca', '<cmd>CodeCompanionActions<CR>')
vim.keymap.set('n', '<leader>cc', '<cmd>CodeCompanionChat<CR>')
vim.keymap.set('v', '<leader>cc', '<cmd>CodeCompanionChat<CR>')
