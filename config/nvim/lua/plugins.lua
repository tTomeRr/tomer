return {

  -- Colorscheme
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require('onedark').setup({
        style = 'dark',
        transparent = true,
        term_colors = true,
        ending_tildes = false,
        cmp_itemkind_reverse = false,
      })
      require('onedark').load()
    end,
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup()
      vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")
    end,
  },

  -- Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "yaml", "dockerfile", "bash", "python", "lua", "markdown", "markdown_inline", "go", "gomod", "gowork", "gosum" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Markdown rendering
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('render-markdown').setup({})
      vim.keymap.set('n', 'tm', '<cmd>RenderMarkdown toggle<CR>', { desc = 'Toggle markdown rendering' })
    end,
  },

  -- Linting
  {
    "mfussenegger/nvim-lint",
    config = function()
      require('lint').linters_by_ft = {
        yaml = { 'yamllint' },
        python = { 'flake8' },
        bash = { 'shellcheck' },
        sh = { 'shellcheck' },
        go = { 'golangcilint' },
      }

      -- Configure diagnostics to always show
      vim.diagnostic.config({
        virtual_text = true,           -- Show inline error messages
        signs = true,                  -- Show signs in gutter
        underline = true,              -- Underline errors
        update_in_insert = true,       -- Update diagnostics in insert mode
        severity_sort = true,          -- Sort by severity
        float = {
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      -- Auto-lint on save, enter, and text changes
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "TextChanged", "TextChangedI" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })

      -- Toggle diagnostics with 'tg'
      vim.keymap.set("n", "tg", function()
        local current_config = vim.diagnostic.config()
        if current_config.virtual_text then
          vim.diagnostic.config({
            virtual_text = false,
            signs = false,
            underline = false,
          })
        else
          vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            underline = true,
          })
        end
      end, { desc = "Toggle diagnostics" })
    end,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "gopls" },
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      lspconfig.gopls.setup({
        capabilities = capabilities,
        settings = {
          gopls = {
            gofumpt = true,
            usePlaceholders = true,
            completeUnimported = true,
          },
        },
      })

    end,
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          go = { "gofumpt" },
          python = { "black", "isort" },
          bash = { "shfmt" },
          sh = { "shfmt" },
          yaml = { "prettier" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
      
      vim.keymap.set("n", "<leader>f", function()
        require("conform").format({ async = true, lsp_fallback = true })
      end, { desc = "Format file" })
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
        },
      })
    end,
  },

}