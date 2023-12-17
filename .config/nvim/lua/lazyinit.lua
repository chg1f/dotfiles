-- encoding=utf-8

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.print("Installing lazy.nvim...")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { -- colorscheme
      url = "https://github.com/navarasu/onedark.nvim",
      --url = "https://github.com/sainnhe/sonokai",
      --url = "https://github.com/folke/tokyonight.nvim",
      --url = "https://github.com/flazz/vim-colorschemes",
      priority = 1000,
      config = function()
        local onedark = require("onedark")
        onedark.setup({
          -- Main options --
          style = 'dark',               -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
          transparent = false,          -- Show/hide background
          term_colors = true,           -- Change terminal color as per the selected theme style
          ending_tildes = false,        -- Show the end-of-buffer tildes. By default they are hidden
          cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

          -- toggle theme style ---
          toggle_style_key = nil,                                                              -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
          toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between

          -- Change code style ---
          -- Options are italic, bold, underline, none
          -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
          code_style = {
            comments = 'italic',
            keywords = 'none',
            functions = 'none',
            strings = 'none',
            variables = 'none'
          },

          -- Lualine options --
          lualine = {
            transparent = false, -- lualine center bar transparency
          },

          -- Custom Highlights --
          colors = {},     -- Override default colors
          highlights = {}, -- Override highlight groups

          -- Plugins Config --
          diagnostics = {
            darker = true,     -- darker colors for diagnostic
            undercurl = true,  -- use undercurl instead of underline for diagnostics
            background = true, -- use background color for virtual text
          },
        })
        onedark.load()
        vim.cmd([[colo onedark]])
      end,
    },
    { -- syntax
      url = "https://github.com/nvim-treesitter/nvim-treesitter",
      config = function()
        require('nvim-treesitter.configs').setup({
          -- A list of parser names, or "all" (the five listed parsers should always be installed)
          ensure_installed = {},

          -- Install parsers synchronously (only applied to `ensure_installed`)
          sync_install = false,

          -- Automatically install missing parsers when entering buffer
          -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
          auto_install = false,

          -- List of parsers to ignore installing (or "all")
          ignore_install = {},

          ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
          -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

          highlight = {
            enable = true,

            -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
            -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
            -- the name of the parser)
            -- list of language that will be disabled
            -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
            disable = function(_, buf)
              local max_filesize = 100 * 1024 -- 100 KB
              local ok, stats = pcall(vim.loop.fs_stat,
                vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                return true
              end
            end,

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
          },
          indent = {
            enable = true,
            disable = function()
              return true
            end
          }
        })
      end
    },
    { url = "https://github.com/editorconfig/editorconfig-vim" },
    { -- bookmarks
      url = "https://github.com/tomasky/bookmarks.nvim",
      config = function()
        local bookmarks = require("bookmarks")
        bookmarks.setup {
          -- sign_priority = 8,  --set bookmark sign priority to cover other sign
          save_file = vim.fn.stdpath("data") .. "/bookmarks",
          keywords = {
            ["@t"] = "t", -- mark annotation startswith @t ,signs this icon as `TODO`
            ["@b"] = "b", -- mark annotation startswith @w ,signs this icon as `BUG`
            ["@f"] = "f", -- mark annotation startswith @f ,signs this icon as `FIXME`
            ["@x"] = "x", -- mark annotation startswith @x ,signs this icon as `XXX`
          },
          on_attach = function()
            vim.keymap.set("n", "ma", bookmarks.bookmark_ann)    -- add or edit mark annotation at current line
            vim.keymap.set("n", "mm", bookmarks.bookmark_toggle) -- add or remove bookmark at current line
            vim.keymap.set("n", "mn", bookmarks.bookmark_next)   -- jump to next mark in local buffer
            vim.keymap.set("n", "mp", bookmarks.bookmark_prev)   -- jump to previous mark in local buffer
            --vim.keymap.set("n", "mc", bookmarks.bookmark_clean) -- clean all marks in local buffer
            --vim.keymap.set("n", "ml", bookmarks.bookmark_list) -- show marked file list in quickfix window
          end
        }
      end
    },

    { -- toolkit manager
      url = "https://github.com/williamboman/mason.nvim",
      priority = 900,
      config = function()
        ---@class MasonSettings
        require("mason").setup({
          ---@since 1.0.0
          -- The directory in which to install packages.
          install_root_dir = vim.fn.stdpath("data") .. "/mason",

          ---@since 1.0.0
          -- Where Mason should put its bin location in your PATH. Can be one of:
          -- - "prepend" (default, Mason's bin location is put first in PATH)
          -- - "append" (Mason's bin location is put at the end of PATH)
          -- - "skip" (doesn't modify PATH)
          ---@type '"prepend"' | '"append"' | '"skip"'
          PATH = "prepend",

          ---@since 1.0.0
          -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
          -- debugging issues with package installations.
          log_level = vim.log.levels.INFO,

          ---@since 1.0.0
          -- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
          -- packages that are requested to be installed will be put in a queue.
          max_concurrent_installers = jit.os:find("Windows") and
              (vim.loop.available_parallelism() * 2) or 4,

          ---@since 1.0.0
          -- [Advanced setting]
          -- The registries to source packages from. Accepts multiple entries. Should a package with the same name exist in
          -- multiple registries, the registry listed first will be used.
          registries = {
            "github:mason-org/mason-registry",
          },

          ---@since 1.0.0
          -- The provider implementations to use for resolving supplementary package metadata (e.g., all available versions).
          -- Accepts multiple entries, where later entries will be used as fallback should prior providers fail.
          -- Builtin providers are:
          --   - mason.providers.registry-api  - uses the https://api.mason-registry.dev API
          --   - mason.providers.client        - uses only client-side tooling to resolve metadata
          providers = {
            "mason.providers.registry-api",
            "mason.providers.client",
          },

          github = {
            ---@since 1.0.0
            -- The template URL to use when downloading assets from GitHub.
            -- The placeholders are the following (in order):
            -- 1. The repository (e.g. "rust-lang/rust-analyzer")
            -- 2. The release version (e.g. "v0.3.0")
            -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
            download_url_template = "https://github.com/%s/releases/download/%s/%s",
          },

          pip = {
            ---@since 1.0.0
            -- Whether to upgrade pip to the latest version in the virtual environment before installing packages.
            upgrade_pip = false,

            ---@since 1.0.0
            -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
            -- and is not recommended.
            --
            -- Example: { "--proxy", "https://proxyserver" }
            install_args = {},
          },

          ui = {
            ---@since 1.0.0
            -- Whether to automatically check for new versions when opening the :Mason window.
            check_outdated_packages_on_open = true,

            ---@since 1.0.0
            -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
            border = "none",

            ---@since 1.0.0
            -- Width of the window. Accepts:
            -- - Integer greater than 1 for fixed width.
            -- - Float in the range of 0-1 for a percentage of screen width.
            width = 0.8,

            ---@since 1.0.0
            -- Height of the window. Accepts:
            -- - Integer greater than 1 for fixed height.
            -- - Float in the range of 0-1 for a percentage of screen height.
            height = 0.9,

            icons = {
              ---@since 1.0.0
              -- The list icon to use for installed packages.
              package_installed = "◍",
              ---@since 1.0.0
              -- The list icon to use for packages that are installing, or queued for installation.
              package_pending = "◍",
              ---@since 1.0.0
              -- The list icon to use for packages that are not installed.
              package_uninstalled = "◍",
            },

            keymaps = {
              ---@since 1.0.0
              -- Keymap to expand a package
              toggle_package_expand = "<CR>",
              ---@since 1.0.0
              -- Keymap to install the package under the current cursor position
              install_package = "i",
              ---@since 1.0.0
              -- Keymap to reinstall/update the package under the current cursor position
              update_package = "u",
              ---@since 1.0.0
              -- Keymap to check for new version for the package under the current cursor position
              check_package_version = "c",
              ---@since 1.0.0
              -- Keymap to update all installed packages
              update_all_packages = "U",
              ---@since 1.0.0
              -- Keymap to check which installed packages are outdated
              check_outdated_packages = "C",
              ---@since 1.0.0
              -- Keymap to uninstall a package
              uninstall_package = "X",
              ---@since 1.0.0
              -- Keymap to cancel a package installation
              cancel_installation = "<C-c>",
              ---@since 1.0.0
              -- Keymap to apply language filter
              apply_language_filter = "<C-f>",
              ---@since 1.1.0
              -- Keymap to toggle viewing package installation log
              toggle_package_install_log = "<CR>",
              ---@since 1.8.0
              -- Keymap to toggle the help view
              toggle_help = "g?",
            },
          },
        })
      end
    },
    { -- lsp client
      url = "https://github.com/neovim/nvim-lspconfig",
      priority = 800,
      dependencies = {
        {
          url = "https://github.com/williamboman/mason-lspconfig.nvim",
          config = function()
            require("mason-lspconfig").setup({
              -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
              -- This setting has no relation with the `automatic_installation` setting.
              ---@type string[]
              ensure_installed = {
                "typos_lsp",
                "ast_grep",
                "efm",

                "tsserver",
                "eslint",
                "biome",
                "cssmodules_ls",

                "dockerls",                        -- docker
                "docker_compose_language_service", -- docker-compose
                "jqls",                            -- json
                "pyright",                         -- python
                "lua_ls",                          -- lua
                -- "golangci_lint_ls", -- golang
                -- "gopls", -- golang
                "taplo",   -- toml
                "lemminx", -- xml
                "yamlls",  -- yaml
              },

              -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
              -- This setting has no relation with the `ensure_installed` setting.
              -- Can either be:
              --   - false: Servers are not automatically installed.
              --   - true: All servers set up via lspconfig are automatically installed.
              --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
              --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
              ---@type boolean
              automatic_installation = true,

              -- See `:h mason-lspconfig.setup_handlers()`
              ---@type table<string, fun(server_name: string)>?
              handlers = nil,
            })
          end
        },
        {
          url = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
          dependencies = {
          },
          config = function()
            require('mason-tool-installer').setup({
              -- if set to true this will check each tool for updates. If updates
              -- are available the tool will be updated. This setting does not
              -- affect :MasonToolsUpdate or :MasonToolsInstall.
              -- Default: false
              auto_update = true,

              -- automatically install / update on startup. If set to false nothing
              -- will happen on startup. You can use :MasonToolsInstall or
              -- :MasonToolsUpdate to install tools and check for updates.
              -- Default: true
              run_on_start = true,

              -- set a delay (in ms) before the installation starts. This is only
              -- effective if run_on_start is set to true.
              -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
              -- Default: 0
              start_delay = 3000, -- 3 second delay

              -- Only attempt to install if 'debounce_hours' number of hours has
              -- elapsed since the last time Neovim was started. This stores a
              -- timestamp in a file named stdpath('data')/mason-tool-installer-debounce.
              -- This is only relevant when you are using 'run_on_start'. It has no
              -- effect when running manually via ':MasonToolsInstall' etc....
              -- Default: nil
              debounce_hours = 5, -- at least 5 hours between attempts to install/update

              -- a list of all tools you want to ensure are installed upon
              -- start
              ensure_installed = {
                "black",
                "shfmt",
                "shellcheck",
              },
            })
          end
        },
        {
          url = "https://github.com/fatih/vim-go",
          build = function()
            vim.cmd([[GoUpdateBinaries]])
          end,
          config = function()
            vim.g.go_def_mapping_enabled = 0
            vim.g.go_gopls_enabled = 0
            vim.g.go_code_completion_enabled = 0
          end
        },
        { url = "https://github.com/hrsh7th/cmp-nvim-lsp" },
        { url = "https://github.com/creativenull/efmls-configs-nvim" },
      },
      config = function()
        -- Set up lspconfig.
        local lspconfig = require('lspconfig')

        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        lspconfig.typos_lsp.setup({
          capabilities = capabilities,
        })
        lspconfig.ast_grep.setup({
          capabilities = capabilities,
        })
        lspconfig.efm.setup({
          capabilities = capabilities,
          init_options = {
            documentFormatting = true,
            documentRangeFormatting = true,
            hover = true,
            documentSymbol = true,
            codeAction = true,
            completion = true
          },
          settings = {
            rootMarkers = { ".git/" },
            languages = {
              typescript = {
                require('efmls-configs.linters.eslint'),
                require('efmls-configs.formatters.prettier'),
              },
              json = {
                require('efmls-configs.formatters.jq'),
              },
              python = {
                require('efmls-configs.formatters.black'),
              },
              sh = {
                require('efmls-configs.linters.shellcheck'),
                require("efmls-configs.formatters.shfmt"),
              },
              sql = {
                require('efmls-configs.formatters.sql-formatter'),
              },
            }
          }
        })

        lspconfig.jsonls.setup({ -- typescript
          capabilities = capabilities,
        })
        lspconfig.sqlls.setup({ -- typescript
          capabilities = capabilities,
        })


        lspconfig.eslint.setup({ -- typescript
          capabilities = capabilities,
        })
        lspconfig.tsserver.setup({ -- typescript
          capabilities = capabilities,
        })
        -- lspconfig.biome.setup({  -- typescript
        --   capabilities = capabilities,
        -- })
        -- lspconfig.cssmodules_ls.setup({  -- typescript
        --   capabilities = capabilities,
        -- })


        lspconfig.dockerls.setup { -- docker
          capabilities = capabilities,
        }
        lspconfig.docker_compose_language_service.setup { -- docker-comopse
          capabilities = capabilities,
        }
        lspconfig.jqls.setup { -- json
          capabilities = capabilities,
        }
        lspconfig.pyright.setup { -- python
          capabilities = capabilities,
        }
        lspconfig.lua_ls.setup { -- lua
          capabilities = capabilities,
          settings = {
            Lua = {
              runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
              },
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {
                  'vim',
                },
              },
              workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
              },
              -- Do not send telemetry data containing a randomized but unique identifier
              telemetry = {
                enable = false,
              },
            },
          },
        }
        lspconfig.golangci_lint_ls.setup { -- golang
          capabilities = capabilities,
        }
        lspconfig.gopls.setup { -- golang
          capabilities = capabilities,
          settings = {
            settings = {
              gopls = {
                analyses = {
                  unusedparams = true,
                },
                staticcheck = true,
                -- gofumpt = true,
              },
            },
          },
        }
        lspconfig.taplo.setup { -- toml
          capabilities = capabilities,
        }
        lspconfig.lemminx.setup { -- xml
          capabilities = capabilities,
        }
        lspconfig.yamlls.setup { -- yaml
          capabilities = capabilities,
        }

        -- Global mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        --vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
        --vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('UserLspConfig', {}),
          callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = ev.buf }

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<space>ff',
              function() vim.lsp.buf.format { async = true } end, opts)
            vim.keymap.set('n', '\'rn', vim.lsp.buf.rename, opts)

            --vim.keymap.set('n', 'gr', ':vsplit | vim.lsp.buf.references()<CR>', opts)
            --vim.keymap.set('n', 'gd', ':vsplit | lua vim.lsp.buf.definition()<CR>', opts)
            --vim.keymap.set('n', 'gD', ':vsplit | vim.lsp.buf.type_definition()<CR>', opts)
            --vim.keymap.set('n', 'gi', ':vsplit | vim.lsp.buf.implementation()<CR>', opts)
            vim.keymap.set('n', 'ge', ':vsplit | lua vim.lsp.buf.declaration()<CR>', opts)
            vim.keymap.set({ 'n', 'v' }, '\'ca', vim.lsp.buf.code_action, opts)

            vim.keymap.set('n', '\'wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '\'wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '\'wl', function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
          end,
        })
        vim.lsp.set_log_level("warn")
      end
    },
    { -- dap client
      url = "https://github.com/mfussenegger/nvim-dap",
      priority = 799,
      dependencies = {
        { url = "https://github.com/rcarriga/nvim-dap-ui" },
      },
      config = function()
        local dap = require("dap")
        dap.adapters.delve = {
          type = 'server',
          port = '${port}',
          executable = {
            command = 'dlv',
            args = { 'dap', '-l', '127.0.0.1:${port}' },
          }
        }
        dap.configurations.go = {
          {
            type = "delve",
            name = "Debug",
            request = "launch",
            program = "${file}"
          },
          {
            type = "delve",
            name = "Debug test", -- configuration for debugging test files
            request = "launch",
            mode = "test",
            program = "${file}"
          },
          -- works with go.mod packages and sub packages
          {
            type = "delve",
            name = "Debug test (go.mod)",
            request = "launch",
            mode = "test",
            program = "./${relativeFileDirname}"
          }
        }
      end,
    },
    { -- completion
      url = "https://github.com/hrsh7th/nvim-cmp",
      priority = 799,
      dependencies = {
        {
          url = "https://github.com/zbirenbaum/copilot-cmp",
          dependencies = {
            {
              url = "https://github.com/zbirenbaum/copilot.lua",
              build = function()
                vim.cmd("Copilot auth")
              end,
              config = function()
                require("copilot").setup({
                  copilot_node_command = vim.g.node_host_prog
                })
              end
            },
          },
          config = function()
            require("copilot_cmp").setup({})
          end
        },
        { url = "https://github.com/hrsh7th/cmp-buffer" },
        { url = "https://github.com/hrsh7th/cmp-path" },
        { url = "https://github.com/hrsh7th/cmp-cmdline" },
        { url = "https://github.com/lukas-reineke/cmp-under-comparator" },
        { url = "https://github.com/hrsh7th/vim-vsnip" },
        { url = "https://github.com/hrsh7th/vim-vsnip-integ" },
        { url = "https://github.com/hrsh7th/cmp-nvim-lua" },
        { url = "https://github.com/petertriho/cmp-git" },
        { url = "https://github.com/delphinus/cmp-ctags" },
        { url = "https://github.com/lukas-reineke/cmp-rg" },
      },
      config = function()
        -- Set up nvim-cmp.
        local cmp = require 'cmp'

        cmp.setup({
          snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
              vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            end,
          },
          window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          }),
          sources = cmp.config.sources({
            { name = 'copilot', group_index = 2 },
            { name = 'nvim_lsp' },
            { name = 'vsnip' },
            { name = "git" },
            { name = 'nvim_lua' },
          }, {
            { name = 'buffer' },
          })
        })

        -- Set configuration for specific filetype.
        cmp.setup.filetype('gitcommit', {
          sources = cmp.config.sources({
            { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
          }, {
            { name = 'buffer' },
          })
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = 'buffer' }
          }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = 'path' }
          }, {
            { name = 'cmdline' }
          })
        })
      end
    },

    {
      url = "https://github.com/yorickpeterse/nvim-window",
      config = function()
        local window = require('nvim-window')
        window.setup({
          -- The characters available for hinting windows.
          chars = {
            'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
            'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
          },

          -- A group to use for overwriting the Normal highlight group in the floating
          -- window. This can be used to change the background color.
          normal_hl = 'Normal',

          -- The highlight group to apply to the line that contains the hint characters.
          -- This is used to make them stand out more.
          hint_hl = 'Bold',

          -- The border style to use for the floating window.
          border = 'single'
        })
        vim.keymap.set('n', '\'w', window.pick, {})
      end
    },
    { -- statusline
      url = "https://github.com/nvim-lualine/lualine.nvim",
      priority = 49,
      config = function()
        require('lualine').setup {
          options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
              statusline = {},
              winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
              statusline = 1000,
              tabline = 1000,
              winbar = 1000,
            }
          },
          sections = {
            lualine_a = {
              'mode',
            },
            lualine_b = {
              {
                'diagnostics',
                symbols = {
                  error = 'E',
                  warn = 'W',
                  info = 'I',
                  hint = 'H',
                },
              },
            },
            lualine_c = {
              {
                'filename',
                file_status = true,
                newfile_status = true,
                path = 1,
                symbols = {
                  modified = '[+]',
                  readonly = '[RO]',
                  unnamed = '[uname]',
                  newfile = '[new]',
                },
              },
              {
                'branch',
                icon = '',
              },
              {
                'diff',
              }
            },
            lualine_x = {
              'searchcount',
            },
            lualine_y = {
              'encoding',
              {
                'fileformat',
                symbols = { unix = 'LF', dos = 'CRLF', mac = 'CR' },
              },
              'filetype',
            },
            lualine_z = {
              'location',
              'progress'
            }
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {
              {
                'filename',
                file_status = true,
                newfile_status = true,
                path = 1,
              },
            },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
          },
          tabline = {},
          winbar = {},
          inactive_winbar = {},
          extensions = {}
        }
      end
    },
    { -- cursorline
      url = "https://github.com/RRethy/vim-illuminate",
      priority = 49,
      config = function()
        -- default configuration
        require('illuminate').configure({
          -- providers: provider used to get references in the buffer, ordered by priority
          providers = {
            'lsp',
            'treesitter',
            'regex',
          },
          -- delay: delay in milliseconds
          delay = 100,
          -- filetype_overrides: filetype specific overrides.
          -- The keys are strings to represent the filetype while the values are tables that
          -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
          filetype_overrides = {},
          -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
          filetypes_denylist = {
            'dirbuf',
            'dirvish',
            'fugitive',
          },
          -- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
          -- You must set filetypes_denylist = {} to override the defaults to allow filetypes_allowlist to take effect
          filetypes_allowlist = {},
          -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
          -- See `:help mode()` for possible values
          modes_denylist = {},
          -- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
          -- See `:help mode()` for possible values
          modes_allowlist = {},
          -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
          -- Only applies to the 'regex' provider
          -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
          providers_regex_syntax_denylist = {},
          -- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
          -- Only applies to the 'regex' provider
          -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
          providers_regex_syntax_allowlist = {},
          -- under_cursor: whether or not to illuminate under the cursor
          under_cursor = true,
          -- large_file_cutoff: number of lines at which to use large_file_config
          -- The `under_cursor` option is disabled when this cutoff is hit
          large_file_cutoff = nil,
          -- large_file_config: config to use for large files (based on large_file_cutoff).
          -- Supports the same keys passed to .configure
          -- If nil, vim-illuminate will be disabled for large files.
          large_file_overrides = nil,
          -- min_count_to_highlight: minimum number of matches required to perform highlighting
          min_count_to_highlight = 1,
          -- should_enable: a callback that overrides all other settings to
          -- enable/disable illumination. This will be called a lot so don't do
          -- anything expensive in it.
          should_enable = function() return true end,
          -- case_insensitive_regex: sets regex case sensitivity
          case_insensitive_regex = false,
        })
      end
    },
    { -- fuzzy
      url = "https://github.com/nvim-telescope/telescope.nvim",
      priority = 1,
      dependencies = {
        { url = "https://github.com/nvim-lua/plenary.nvim" },
        { url = "https://github.com/nvim-tree/nvim-web-devicons" },
        { url = "https://github.com/tom-anders/telescope-vim-bookmarks.nvim" },
        { url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      },
      findRootDirectory = function()
        -- TODO
        return vim.loop.cwd()
      end,
      config = function()
        local telescope = require('telescope')
        -- local extensions = require('telescope').extensions
        telescope.load_extension('bookmarks')
        telescope.setup {
          defaults = {
            -- Default configuration for telescope goes here:
            -- config_key = value,
            mappings = {
              i = {
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                ["<C-h>"] = "which_key"
              }
            },
            layout_strategy = 'vertical',
            layout_config = {
              height = 0.95,
              width = 0.95,
            },
          },
          pickers = {
            builtin = {
              include_extensions = true,
              use_default_opts = true,
            },
            find_files = {
              hidden = true,
              no_ignore = true,
              no_ignore_parent = true,
              mappings = {
                i = {
                  ["<C-g>"] = function(prompt_bufnr)
                    local current_picker =
                        require("telescope.actions.state")
                        .get_current_picker(prompt_bufnr)
                    -- cwd is only set if passed as telescope option
                    local cwd = current_picker.cwd and
                        tostring(current_picker.cwd)
                        or vim.loop.cwd()
                    local parent_dir = vim.fs.dirname(cwd)

                    require("telescope.actions").close(
                      prompt_bufnr)
                    require("telescope.builtin").find_files {
                      prompt_title = parent_dir,
                      cwd = parent_dir,
                    }
                  end,
                },
              },
            },
            live_grep = {
              mappings = {
                i = {
                  ["<C-g>"] = function(prompt_bufnr)
                    local current_picker =
                        require("telescope.actions.state")
                        .get_current_picker(prompt_bufnr)
                    -- cwd is only set if passed as telescope option
                    local cwd = current_picker.cwd and
                        tostring(current_picker.cwd)
                        or vim.loop.cwd()
                    local parent_dir = vim.fs.dirname(cwd)

                    require("telescope.actions").close(
                      prompt_bufnr)
                    require("telescope.builtin").live_grep {
                      prompt_title = parent_dir,
                      cwd = parent_dir,
                    }
                  end,
                },
              },
            },
            diagnostics = {
              --bufnr = 0
              line_width = 'full',
            },
            lsp_references = {
              jump_type = "vsplit",
            },
            lsp_definitions = {
              jump_type = "vsplit",
            },
            lsp_type_definitions = {
              jump_type = "vsplit",
            },
            lsp_implementations = {
              jump_type = "vsplit",
            },
          },
          extensions = {
            fzf = {
              fuzzy = true,                   -- false will only do exact matching
              override_generic_sorter = true, -- override the generic sorter
              override_file_sorter = true,    -- override the file sorter
              case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
              -- the default case_mode is "smart_case"
            },
            bookmarks = {},
          }
        }
        telescope.load_extension('vim_bookmarks')

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '\'t', builtin.builtin, {})
        vim.keymap.set('n', '\'f', builtin.find_files, {})
        vim.keymap.set('n', '\'g', builtin.live_grep, {})
        vim.keymap.set('n', '\'b', builtin.buffers, {})
        vim.keymap.set('n', '\'d', builtin.diagnostics, {})
        -- TODO: vim.keymap.set('n', '\'m', extensions.bookmarks.list())

        vim.keymap.set('n', 'gr', builtin.lsp_references, {})
        vim.keymap.set('n', 'gd', builtin.lsp_definitions, {})
        vim.keymap.set('n', 'gD', builtin.lsp_type_definitions, {})
        vim.keymap.set('n', 'gi', builtin.lsp_implementations, {})
      end
    },
    -- {  -- fuzzy finder
    -- 	url = "https://github.com/junegunn/fzf.vim", dependencies = {
    -- 		{
    -- 			url = "https://github.com/junegunn/fzf",
    -- 			build = function()
    -- 				vim.cmd([[fzf#install()]])
    -- 			end
    -- 		},
    -- 	},
    -- 	config = function()
    -- 		vim.g.fzf_vim = {}
    -- 	end
    -- },
  },
  {
    root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
    defaults = {
      lazy = false,                           -- TODO: should plugins be lazy-loaded?
      version = nil,
      -- default `cond` you can use to globally disable a lot of plugins
      -- when running inside vscode for example
      cond = nil, ---@type boolean|fun(self:LazyPlugin):boolean|nil
      -- version = "*", -- enable this to try installing the latest stable versions of plugins
    },
    -- leave nil when passing the spec as the first argument to setup()
    spec = nil, ---@type LazySpec
    lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
    concurrency = jit.os:find("Windows") and (vim.loop.available_parallelism() * 2) or 4, ---@type number limit the maximum amount of concurrent tasks
    git = {
      -- defaults for the `Lazy log` command
      -- log = { "-10" }, -- show the last 10 commits
      log = { "-8" }, -- show commits from the last 3 days
      timeout = 120,  -- kill processes that take more than 2 minutes
      url_format = "https://github.com/%s.git",
      -- lazy.nvim requires git >=2.19.0. If you really want to use lazy with an older version,
      -- then set the below to false. This should work, but is NOT supported and will
      -- increase downloads a lot.
      filter = true,
    },
    dev = {
      -- directory where you store your local plugin projects
      path = "~/projects",
      ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
      patterns = {},    -- For example {"folke"}
      fallback = false, -- Fallback to git when local plugin doesn't exist
    },
    install = {
      -- install missing plugins on startup. This doesn't increase startup time.
      missing = true,
      -- try to load one of these colorschemes when starting an installation during startup
      colorscheme = { "habamax" },
    },
    ui = {
      -- a number <1 is a percentage., >1 is a fixed size
      size = { width = 0.8, height = 0.8 },
      wrap = true, -- wrap the lines in the ui
      -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
      border = "none",
      title = nil, ---@type string only works when border is not "none"
      title_pos = "center", ---@type "center" | "left" | "right"
      -- Show pills on top of the Lazy window
      pills = true, ---@type boolean
      icons = {
        cmd = " ",
        config = "",
        event = "",
        ft = " ",
        init = " ",
        import = " ",
        keys = " ",
        lazy = "󰒲 ",
        loaded = "●",
        not_loaded = "○",
        plugin = " ",
        runtime = " ",
        require = "󰢱 ",
        source = " ",
        start = "",
        task = "✔ ",
        list = {
          "●",
          "➜",
          "★",
          "‒",
        },
      },
      -- leave nil, to automatically select a browser depending on your OS.
      -- If you want to use a specific browser, you can define it here
      browser = nil, ---@type string?
      throttle = 20, -- how frequently should the ui process render events
      custom_keys = {
        -- You can define custom key maps here. If present, the description will
        -- be shown in the help menu.
        -- To disable one of the defaults, set it to false.

        ["<localleader>l"] = {
          function(plugin)
            require("lazy.util").float_term({ "lazygit", "log" }, {
              cwd = plugin.dir,
            })
          end,
          desc = "Open lazygit log",
        },

        ["<localleader>t"] = {
          function(plugin)
            require("lazy.util").float_term(nil, {
              cwd = plugin.dir,
            })
          end,
          desc = "Open terminal in plugin dir",
        },
      },
    },
    diff = {
      -- diff command <d> can be one of:
      -- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
      --   so you can have a different command for diff <d>
      -- * git: will run git diff and open a buffer with filetype git
      -- * terminal_git: will open a pseudo terminal with git diff
      -- * diffview.nvim: will open Diffview to show the diff
      cmd = "git",
    },
    checker = {
      -- automatically check for plugin updates
      enabled = false,
      concurrency = nil, ---@type number? set to 1 to check for updates very slowly
      notify = true,        -- get a notification when new updates are found
      frequency = 3600,     -- check for updates every hour
      check_pinned = false, -- check for pinned packages that can't be updated
    },
    change_detection = {
      -- automatically check for config file changes and reload the ui
      enabled = true,
      notify = true, -- get a notification when changes are found
    },
    performance = {
      cache = {
        enabled = true,
      },
      reset_packpath = true, -- reset the package path to improve startup time
      rtp = {
        reset = true,        -- reset the runtime path to $VIMRUNTIME and your config directory
        ---@type string[]
        paths = {},          -- add any custom paths here that you want to includes in the rtp
        ---@type string[] list any plugins you want to disable here
        disabled_plugins = {
          -- "gzip",
          -- "matchit",
          -- "matchparen",
          -- "netrwPlugin",
          -- "tarPlugin",
          -- "tohtml",
          -- "tutor",
          -- "zipPlugin",
        },
      },
    },
    -- lazy can generate helptags from the headings in markdown readme files,
    -- so :help works even for plugins that don't have vim docs.
    -- when the readme opens with :help it will be correctly displayed as markdown
    readme = {
      enabled = true,
      root = vim.fn.stdpath("state") .. "/lazy/readme",
      files = { "README.md", "lua/**/README.md" },
      -- only generate markdown helptags for plugins that dont have docs
      skip_if_doc_exists = true,
    },
    state = vim.fn.stdpath("state") .. "/lazy/state.json", -- state info for checker and other things
    build = {
      -- Plugins can provide a `build.lua` file that will be executed when the plugin is installed
      -- or updated. When the plugin spec also has a `build` command, the plugin's `build.lua` not be
      -- executed. In this case, a warning message will be shown.
      warn_on_override = true,
    },
    -- Enable profiling of lazy.nvim. This will add some overhead,
    -- so only enable this when you are debugging lazy.nvim
    profiling = {
      -- Enables extra stats on the debug tab related to the loader cache.
      -- Additionally gathers stats about all package.loaders
      loader = false,
      -- Track each new require in the Lazy profiling tab
      require = false,
    },
  })

-- vim:fdm=indent
