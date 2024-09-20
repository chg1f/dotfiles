-- encoding=utf-8

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  local ret = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", repo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { ret, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "LazyVim/LazyVim",
    import = "lazyvim.plugins",
    ---@type LazyVimConfig
    opts = {
      colorscheme = "tokyonight",
      news = {
        lazyvim = true,
        neovim = true,
      },
      icons = {
        diagnostics = {
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
  {
    "nvimdev/dashboard-nvim",
    enabled = false,
  },
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
              "diagnostics",
              symbols = {
                error = LazyVim.config.icons.diagnostics.Error,
                warn = LazyVim.config.icons.diagnostics.Warn,
                info = LazyVim.config.icons.diagnostics.Info,
                hint = LazyVim.config.icons.diagnostics.Hint,
              },
            },
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
          },
          lualine_c = {
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end, -- # spellchecker:disable-line
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end, -- # spellchecker:disable-line
              color = function() return LazyVim.ui.fg("Statement") end,
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end, -- # spellchecker:disable-line
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end, -- # spellchecker:disable-line
              color = function() return LazyVim.ui.fg("Constant") end,
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = function() return LazyVim.ui.fg("Debug") end,
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
          },
          lualine_x = {
            -- "branch",
            -- LazyVim.lualine.pretty_path(),
            "filesize",
            "encoding",
            {
              "fileformat",
              symbols = { unix = "LF", dos = "CRLF", mac = "CR" },
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
      always_show_bufferline = true,
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = ":" },
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
  -- lsp
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        typos_lsp = {
          init_options = {
            diagnosticSeverity = "Hint",
          },
        },
      },
    },
  },
  -- chezmoi
  { "xvzc/chezmoi.nvim" },
}, {
  root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
  lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json", -- lockfile generated after running update.
  defaults = {
    lazy = true, -- plugins lazy loaded by default
    version = false, -- always use the latest git commit
  },
  install = {
    colorscheme = { "tokyonight" }, -- try to load one of these colorschemes when starting an installation during startup
  },
  checker = {
    enabled = true, -- automatically check for plugin updates
    frequency = 86400, -- check for updates every day
  },
  performance = {
    rtp = {
      disabled_plugins = { -- disable some rtp plugins
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- options
vim.opt.mouse = ""

-- keymaps
-- autocmds
