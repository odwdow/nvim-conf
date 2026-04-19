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
    chat = {
      window = {
        -- List the chat buffer in the buffer list?
        buflisted = true,
        -- Chat window follows when switching tabs
        sticky = false,
        -- float|vertical|horizontal|tab|buffer
        layout = "buffer",
        full_height = false, -- for vertical layout
        -- left|right|top|bottom (nil will default depending on vim.opt.splitright|vim.opt.splitbelow)
        position = nil,
        -- NOTE: You can set these to 0 for auto width/height
        width = 0.4, ---@return number|fun(): number
        height = 0.25, ---@return number|fun(): number
        border = "single",
        relative = "editor",
        -- Ensure that long paragraphs of markdown are wrapped
        opts = {
          breakindent = true,
          linebreak = true,
          wrap = true,
        },
      },
    },
  },
  strategies = {
    -- Change the default chat adapter
    chat = {
      adapter = 'gemini_cli',
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
      adapter = 'gemini',
    },
    cmd = {
      adapter = 'gemini',
    },
  },
  adapters = {
    acp = {
      gemini_cli = function()
        return require("codecompanion.adapters").extend("gemini_cli", {
          defaults = {
            auth_method = "oauth-personal",
          },
        })
      end,
    },
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
      },
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
