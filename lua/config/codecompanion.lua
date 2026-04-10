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
      adapter = 'claude_code',
      keymaps = {
        close = {
          modes = { n = "<C-x>", i = "<C-x>" },
          opts = {},
        },
      },
      tools = {
        ["mcp"] = {
          callback = function()
            return require("mcphub.extensions.codecompanion")
          end,
          opts = {
            requires_approval = true,
            temperature = 0.7
          },
        },
      },
    },
    inline = {
      adapter = 'claude_code',
    },
    cmd = {
      adapter = 'claude_code',
    },
  },
  adapters = {
    acp = {
      claude_code = function()
        local token = vim.fn.system("sops exec-env ~/.secret/claude.yaml 'echo $CLAUDE_CODE_OAUTH_TOKEN'")
        token = vim.trim(token)

        return require("codecompanion.adapters").extend("claude_code", {
          env = {
            CLAUDE_CODE_OAUTH_TOKEN = token,
          },
        })
      end,
    },
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
    markdown = {
      dirs = {
        vim.fn.getcwd() .. "/.prompts",
        "~/.config/nvim/lua/config/prompts",
      },
    },
  },
  extensions = {
    mcphub = {
      callback = "mcphub.extensions.codecompanion",
      opts = {
        make_tools = true,
        show_server_tools_in_chat = true,
        add_mcp_prefix_to_tool_names = false,
        show_result_in_chat = true,
        format_tool = nil,
        make_vars = false,
        make_slash_commands = true,
      }
    }
  },
  interactions = {
    chat = {
      opts = {
        completion_provider = "cmp",
      }
    },
    opts = {
      triggers = {
        acp_slash_commands = "\\",
        editor_context = "#",
        slash_commands = "/",
        tools = "@",
      },
    },
  }
})

vim.keymap.set('n', '<leader>ca', '<cmd>CodeCompanionActions<CR>')
vim.keymap.set('v', '<leader>ca', '<cmd>CodeCompanionActions<CR>')
vim.keymap.set('n', '<leader>cf', '<cmd>CodeCompanion /generate_function<CR>')
vim.keymap.set('v', '<leader>cf', '<cmd>CodeCompanion /generate_function<CR>')
vim.keymap.set('n', '<leader>ci', '<cmd>CodeCompanion /investigate_error<CR>')
vim.keymap.set('v', '<leader>ci', '<cmd>CodeCompanion /investigate_error<CR>')
vim.keymap.set('n', '<leader>cc', '<cmd>CodeCompanionChat<CR>')
vim.keymap.set('v', '<leader>cc', '<cmd>CodeCompanionChat<CR>')
