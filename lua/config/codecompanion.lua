local codecompanion = require("codecompanion")

codecompanion.setup({
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
      adapter = 'gemma3n',
      keymaps = {
        close = {
          modes = { n = "<C-x>", i = "<C-x>" },
          opts = {},
        },
      },
    },
    inline = {
      adapter = 'gemma3n',
    },
  },
  adapters = {
    http = {
      gemma3n = function()
        return require('codecompanion.adapters').extend('ollama', {
          name = 'gemma3n', -- Give this adapter a different name to differentiate it from the default ollama adapter
          schema = {
            model = {
              default = 'gemma3n:e2b',
            },
          },
        })
      end,
    }
  },
  opts = {
    log_level = 'DEBUG',
  },
  prompt_library = {
    ["generate_function"] = {
      strategy = "chat",
      description = "Generate the function content.",
      opts = {
        mapping = "<LocalLeader>cf",
        modes = { "v" },
        short_name = "function",
        auto_submit = true,
        stop_context_insertion = true,
        user_prompt = true,
      },
      prompts = {
        {
          role = "user",
          content = function(context)
            local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

            return "Generate this function content. \n\n```" .. context.filetype .. "\n" .. text .. "\n```\n\n"
          end,
          opts = {
            contains_code = true,
          }
        },
      },
    },
  },
})

vim.keymap.set('n', '<leader>ca', '<cmd>CodeCompanionActions<CR>')
vim.keymap.set('v', '<leader>ca', '<cmd>CodeCompanionActions<CR>')
vim.keymap.set('n', '<leader>cf', '<cmd>CodeCompanion /function<CR>')
vim.keymap.set('v', '<leader>cf', '<cmd>CodeCompanion /function<CR>')
vim.keymap.set('n', '<leader>cc', '<cmd>CodeCompanionChat<CR>')
vim.keymap.set('v', '<leader>cc', '<cmd>CodeCompanionChat<CR>')
