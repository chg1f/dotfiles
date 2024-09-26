---@class LazyVimPlugin
return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
      news = {
        lazyvim = true,
        neovim = false,
      },
      diagnostics = {
        icons = {
          Error = "E",
          Warn = "W",
          Info = "I",
          Hint = "H",
        },
        git = {
          added = "+",
          modified = "~",
          removed = "-",
        },
      },
    },
  },
  -- ui
  { "nvimdev/dashboard-nvim", enabled = false },
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      return {
        options = {
          icons_enabled = false,
          component_separators = "",
          section_separators = "",
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(s)
                return s:sub(1, 1):upper()
              end,
            },
          },
          lualine_b = {
            {
              "diff",
              symbols = {
                added = LazyVim.config.icons.git.added,
                modified = LazyVim.config.icons.git.modified,
                removed = LazyVim.config.icons.git.removed,
              },
              source = function()
                if vim.b.gitsigns_status_dict then
                  return {
                    added = vim.b.gitsigns_status_dict.added,
                    modified = vim.b.gitsigns_status_dict.changed,
                    removed = vim.b.gitsigns_status_dict.removed,
                  }
                end
              end,
            },
            {
              "diagnostics",
              symbols = {
                error = LazyVim.config.icons.diagnostics.Error,
                warn = LazyVim.config.icons.diagnostics.Warn,
                info = LazyVim.config.icons.diagnostics.Info,
                hint = LazyVim.config.icons.diagnostics.Hint,
              },
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = function() return LazyVim.ui.fg("Debug") end,
            },
          },
          lualine_c = {
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end, -- # spellchecker:disable-line
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end, -- # spellchecker:disable-line
              color = function() return LazyVim.ui.fg("Constant") end,
            },
            -- stylua: ignore
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function() return LazyVim.ui.fg("Special") end,
            },
            "progress",
            "location",
            "searchcount",
            "selectioncount",
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end, -- # spellchecker:disable-line
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end, -- # spellchecker:disable-line
              color = function() return LazyVim.ui.fg("Statement") end,
            },
          },
          lualine_x = {
            -- "branch",
            -- LazyVim.lualine.pretty_path(),
            "filesize",
            "encoding",
            {
              "fileformat",
              symbols = {
                unix = "LF",
                dos = "CRLF",
                mac = "CR",
              },
            },
          },
          lualine_y = {
            LazyVim.lualine.root_dir(),
          },
          lualine_z = {
            "filetype",
          },
        },
      }
    end,
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        indicator = { style = "underline" },
        always_show_bufferline = true,
        show_buffer_close_icons = false,
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        changedelete = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        untracked = { text = ":" },
      },
      signs_staged = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      icons = {
        DEBUG = " ",
        ERROR = " ",
        WARN = " ",
        INFO = " ",
        TRACE = " ",
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      -- views = {
      --   cmdline_popup = {
      --     position = { row = "50%", col = "50%" },
      --   },
      --   cmdline_popupmenu = {
      --     relative = "editor",
      --     position = "auto",
      --   },
      -- },
    },
  },
  -- coding
  {
    "mason.nvim",
    opts = {
      install_root = vim.fn.stdpath("data") .. "/mason",
    },
  },
  -- editor
  {
    "folke/todo-comments.nvim",
    opts = {
      keywords = {
        BUG = { icon = " ", color = "error", alt = { "ISSUE", "FIX", "FIXME", "FIXIT" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = "󰾆 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = "󱞂 ", color = "hint", alt = { "INFO", "REFERENCE", "REF" } },
        TEST = { icon = "󰐍 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader><space>",
        function()
          require("telescope.builtin").resume()
        end,
        desc = "Resume",
      },
      {
        "<leader>.",
        function()
          require("telescope.builtin").builtin()
        end,
        desc = "Telescope",
      },
      {
        "<leader>ff",
        LazyVim.pick("files", { root = false, no_ignore = true, hidden = true }),
        desc = "Find Files (cwd)",
      },
      { "<leader>fF", LazyVim.pick("files", { hidden = true }), desc = "Find Files (Root Dir)" },
    },
  },
  -- lsp
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        typos_lsp = {
          init_options = {
            diagnosticSeverity = "Hint",
          },
        },
      },
    },
    keys = {
      -- {
      --   "gd",
      --   "<cmd>FzfLua lsp_definitions ignore_current_line=true<cr>",
      --   desc = "Goto Definition",
      --   has = "definition",
      -- },
      -- {
      --   "gr",
      --   "<cmd>FzfLua lsp_references jump_to_single_result=true ignore_current_line=true<cr>",
      --   desc = "References",
      --   nowait = true,
      -- },
      -- {
      --   "gI",
      --   "<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>",
      --   desc = "Goto Implementation",
      -- },
      -- {
      --   "gy",
      --   "<cmd>FzfLua lsp_typedefs jump_to_single_result=true ignore_current_line=true<cr>",
      --   desc = "Goto T[y]pe Definition",
      -- },
    },
  },
}
