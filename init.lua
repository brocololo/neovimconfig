--[[
====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
Kickstart.nvim is *not* a distribution.
Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, understand
  what your configuration is doing, and modify it to suit your needs.
  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!
  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/
  And then you can explore or search through `:help lua-guide`
Kickstart Guide:
I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.
In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.
I hope you enjoy your Neovim journey,
- TJ
P.S. You can delete this when you're done too. It's your config now :)
--]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  {'neoclide/coc.nvim', branch = 'release'},

  -- ajout mathieu 
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup ({
        sort_by = "name",
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        --filters = {
        --  dotfiles = true,
        --},
      })
    end,
  },

  {
    "hashivim/vim-terraform"
  },
  { 'j-hui/fidget.nvim', opts = {} },
  -- fin ajout mathieu

  -- Detect tabstop and shiftwidth automatically
--  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
--  {
--    -- LSP Configuration & Plugins
--    'neovim/nvim-lspconfig',
--    dependencies = {
--      -- Automatically install LSPs to stdpath for neovim
--      { 'williamboman/mason.nvim', config = true },
--      'williamboman/mason-lspconfig.nvim',
--
--      -- Useful status updates for LSP
--      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
--      { 'j-hui/fidget.nvim', tag = "legacy", event = "LspAttach", opts = {} },
--
--      -- Additional lua configuration, makes nvim stuff amazing!
--      'folke/neodev.nvim',
--    },
--  },

  -- {
  --   -- Autocompletion
  --   'hrsh7th/nvim-cmp',
  --   dependencies = {
  --     -- Snippet Engine & its associated nvim-cmp source
  --     'L3MON4D3/LuaSnip',
  --     'saadparwaiz1/cmp_luasnip',
  --
  --     -- Adds LSP completion capabilities
  --     'hrsh7th/cmp-nvim-lsp',
  --
  --     -- Adds a number of user-friendly snippets
  --     'rafamadriz/friendly-snippets',
  --   },
  -- },
  --
  -- Ajout Mathieu
--  {
  -- java Autocompletion
--  'artur-shaik/jc.nvim', opts = {}
--  },
  --{ 'mfussenegger/nvim-jdtls', opts = {}},
  -- Fin ajout Mathieu

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '[c', require('gitsigns').prev_hunk, { buffer = bufnr, desc = 'Go to Previous Hunk' })
        vim.keymap.set('n', ']c', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'Go to Next Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
  },

  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_c = {{'filename', path = 1}}
      },
      inactive_sections = {
        lualine_c = {{'filename', path = 1}}
      },
    },
  },

  --{
  --  -- Add indentation guides even on blank lines
  --  'lukas-reineke/indent-blankline.nvim',
  --  -- Enable `lukas-reineke/indent-blankline.nvim`
  --  -- See `:help indent_blankline.txt`
  --  opts = {
  --    char = '┊',
  --    show_trailing_blankline_indent = false,
  --  },
  --},

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim', "nvim-telescope/telescope-live-grep-args.nvim" },
    config = function()
      require("telescope").load_extension("live_grep_args")
    end
  },


  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  --{ import = 'custom.plugins' },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = true

vim.o.cursorline = true

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true
-- Use space characters instead of tabs
vim.o.expandtab = true
-- Enable mouse mode
vim.o.mouse = 'a'

vim.o.listchars = "space:·,eol:↵,tab:→→"
vim.o.list = true

-- Do not let cursor scroll below or above N number of lines when scrolling.
vim.o.scrolloff = 10

vim.bo.filetype = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 300
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- pour avoir la colonne limite de ligne visible
vim.o.colorcolumn="100"

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })


-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- treemap short cut
vim.keymap.set("n", "<leader>tt", require("nvim-tree.api").tree.toggle, {
  silent = true,
  desc = "toggle nvim-tree",
})

-- vim.keymap.set("n", "<leader>tf", require("nvim-tree.api").tree.open{find_file = true}, {
--   silent = true,
--   desc = "find file in nvim-tree",
-- })

vim.keymap.set("n", "<leader>tf", '<cmd>NvimTreeFindFile<cr>', {
  silent = true,
  desc = "find file in nvim-tree",
  noremap = true
})

-- vim.keymap.set({'n', 'v'}, '<C-t>', '<cmd>NvimTreeToggle<cr>', {noremap = true})
-- vim.keymap.set({'n', 'v'}, '<C-T>', '<cmd>NvimTreeFindFile<cr>', {noremap = true})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").load_extension("live_grep_args")
local lga_actions = require("telescope-live-grep-args.actions")
require('telescope').setup {
  pickers = {
    find_files = {
      hidden = true
    },
    live_grep = {
      additional_args = function ()
        return {"--hidden"}
      end
    },
  },
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
  extensions = {
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      -- define mappings, e.g.
      mappings = { -- extend mappings
        i = {
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        },
      },
      -- ... also accepts theme settings, for example:
      -- theme = "dropdown", -- use dropdown theme
      -- theme = { }, -- use own theme spec
      -- layout_config = { mirror=true }, -- mirror preview pane
    }
  }
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
vim.keymap.set('n', '<leader>sg', live_grep_args_shortcuts.grep_visual_selection, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, {})

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
-- require('neodev').setup()
--
---- nvim-cmp supports additional completion capabilities, so broadcast that to servers
--local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--
---- Ensure the servers above are installed
--local mason_lspconfig = require 'mason-lspconfig'
--
--mason_lspconfig.setup {
--  ensure_installed = vim.tbl_keys(servers),
--}
--
--mason_lspconfig.setup_handlers {
--  function(server_name)
--    require('lspconfig')[server_name].setup {
--      capabilities = capabilities,
--      on_attach = on_attach,
--      settings = servers[server_name],
--    }
--  end,
--}
--
---- [[ Configure nvim-cmp ]]
---- See `:help cmp`
--local cmp = require 'cmp'
--local luasnip = require 'luasnip'
--require('luasnip.loaders.from_vscode').lazy_load()
--luasnip.config.setup {}
--
--cmp.setup {
--  snippet = {
--    expand = function(args)
--      luasnip.lsp_expand(args.body)
--    end,
--  },
--  completion = {
--    completeopt = 'menu,menuone,noinsert'
--  },
--  mapping = cmp.mapping.preset.insert {
--    ['<C-n>'] = cmp.mapping.select_next_item(),
--    ['<C-p>'] = cmp.mapping.select_prev_item(),
--    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--    ['<C-f>'] = cmp.mapping.scroll_docs(4),
--    ['<C-Space>'] = cmp.mapping.complete {},
--    ['<CR>'] = cmp.mapping.confirm {
--      behavior = cmp.ConfirmBehavior.Replace,
--      select = true,
--    },
--    ['<Tab>'] = cmp.mapping(function(fallback)
--      if cmp.visible() then
--        cmp.select_next_item()
--      elseif luasnip.expand_or_locally_jumpable() then
--        luasnip.expand_or_jump()
--      else
--        fallback()
--      end
--    end, { 'i', 's' }),
--    ['<S-Tab>'] = cmp.mapping(function(fallback)
--      if cmp.visible() then
--        cmp.select_prev_item()
--      elseif luasnip.locally_jumpable(-1) then
--        luasnip.jump(-1)
--      else
--        fallback()
--      end
--    end, { 'i', 's' }),
--  },
--  sources = {
--    { name = 'nvim_lsp' },
--    { name = 'luasnip' },
--  },
--}

local keyset = vim.keymap.set
-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})


-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})


-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})


-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})


-- Formatting selected code
keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})


-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})

-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
local opts = {silent = true, nowait = true}
keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

-- Remap keys for apply code actions at the cursor position.
keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
-- Remap keys for apply source code actions for current file.
keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
-- Apply the most preferred quickfix action on the current line.
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

-- Remap keys for apply refactor code actions.
keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- Run the Code Lens actions on the current line
keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)


-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)


-- Remap <C-f> and <C-b> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true, expr = true}
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset("i", "<C-f>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-b>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)


-- Use CTRL-S for selections ranges
-- Requires 'textDocument/selectionRange' support of language server
keyset("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
keyset("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})


-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true}
-- -- Show all diagnostics
-- keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
-- -- Manage extensions
-- keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
-- -- Show commands
-- keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
-- -- Find symbol of current document
-- keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
-- -- Search workspace symbols
-- keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
-- -- Do default action for next item
-- keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
-- -- Do default action for previous item
-- keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
-- -- Resume latest coc list
-- keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)
-- -- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

--local api = require("nvim-tree.api")
--api.tree.open()
--vim.api.nvim_create_autocmd("BufEnter", {
--  nested = true,
--  callback = function()
--    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
--      vim.cmd "quit"
--    end
--  end
--})
--vim.api.tree.open({ path = "~/dev/smallable/" })
--
-- empty setup using defaults
--require("nvim-tree").setup()

-- OR setup with some options
--require("nvim-tree").setup({
--  sort_by = "case_sensitive",
--  view = {
--    width = 30,
--  },
--  renderer = {
--    group_empty = true,
--  },
--  filters = {
--    dotfiles = true,
--  },
--})
--vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
--vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
--vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
--vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
--vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])
vim.g.coc_filetype_map = {'yaml.ansible', 'ansible'}
vim.g.coc_global_extensions = {'coc-json', 'coc-html', 'coc-prettier', 'coc-css', 'coc-java', 'coc-jedi', 'coc-marketplace'}
-- vim.cmd([[autocmd BufRead,BufNewFile */ansible/**/*.ya?ml set filetype=yaml.ansible]])
vim.cmd([[autocmd BufRead,BufNewFile *.yaml,*.yml set filetype=ansible.yaml]])
vim.opt.path:remove "/usr/include"
vim.opt.path:append "**"
vim.opt.wildignorecase = true
vim.opt.wildignore:append "**/node_modules/*"
vim.opt.wildignore:append "**/.git/*"

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
