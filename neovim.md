Here's the enhanced Neovim configuration integrating Molten.nvim, Astronvim plugins, tectonic for LaTeX, and Emacs-inspired features:

```lua
-- ~/.config/nvim/init.lua
require('core.globals')
require('core.options')
require('core.autocmds')
require('core.keymaps')

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Core plugins
  { import = 'plugins.core' },
  -- UI components
  { import = 'plugins.ui' },
  -- Navigation tools
  { import = 'plugins.navigation' },
  -- LSP and completion
  { import = 'plugins.lsp' },
  -- Debugging tools
  { import = 'plugins.debug' },
  -- Jupyter integration
  { import = 'plugins.jupyter' },
  -- LaTeX support
  { import = 'plugins.tex' },
  -- Markdown tools
  { import = 'plugins.markdown' },
  -- Utilities
  { import = 'plugins.util' },
  -- Astronvim community plugins
  { import = 'plugins.astronvim' },
}, {
  defaults = { lazy = true },
  install = { colorscheme = { 'catppuccin-mocha' } },
  ui = {
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
    border = "rounded",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'netrw', 'netrwPlugin', 'netrwSettings', 'netrwFileHandlers',
        'gzip', 'zip', 'zipPlugin', 'tar', 'tarPlugin', 'getscript',
        'getscriptPlugin', 'vimball', 'vimballPlugin', '2html_plugin',
        'logipat', 'rrhelper', 'spellfile_plugin', 'matchit'
      }
    }
  }
})

require('core.colorscheme')()
```

**Directory Structure:**
```
~/.config/nvim/
├── init.lua
├── lua/
│   ├── core/
│   │   ├── autocmds.lua
│   │   ├── colorscheme.lua
│   │   ├── globals.lua
│   │   ├── keymaps.lua
│   │   └── options.lua
│   ├── plugins/
│   │   ├── astronvim.lua
│   │   ├── core.lua
│   │   ├── debug.lua
│   │   ├── jupyter.lua
│   │   ├── lsp.lua
│   │   ├── markdown.lua
│   │   ├── navigation.lua
│   │   ├── tex.lua
│   │   ├── ui.lua
│   │   └── util.lua
│   └── config.lua
```

### Core Configuration Files
**1. core/globals.lua**
```lua
_G.g = vim.g
_G.opt = vim.opt
_G.cmd = vim.cmd
_G.fn = vim.fn
_G.map = vim.keymap.set
_G.buf_map = function(bufnr, mode, lhs, rhs, opts)
  opts = opts or {}
  opts.buffer = bufnr
  vim.keymap.set(mode, lhs, rhs, opts)
end

g.icons_enabled = true
g.toggle_theme_icon = "   "
g.transparent_enabled = false
g.emacs_mode = true  -- Enable Emacs-inspired features
```

**2. core/options.lua** (Enhanced with Emacs-inspired settings)
```lua
local opt = vim.opt

-- General
opt.backup = false
opt.breakindent = true
opt.clipboard = 'unnamedplus'
opt.cmdheight = 1
opt.completeopt = { 'menuone', 'noselect' }
opt.conceallevel = 2
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.foldcolumn = '1'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'
opt.hidden = true
opt.ignorecase = true
opt.inccommand = 'split'
opt.laststatus = 3
opt.list = true
opt.listchars = {
  tab = '» ',
  trail = '·',
  nbsp = '␣',
  extends = '…',
  precedes = '…',
}
opt.mouse = 'a'
opt.number = true
opt.pumblend = 10
opt.pumheight = 10
opt.relativenumber = true
opt.scrolloff = 8
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize' }
opt.shiftround = true
opt.shiftwidth = 4
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false
opt.sidescrolloff = 8
opt.signcolumn = 'yes'
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitkeep = 'screen'
opt.splitright = true
opt.tabstop = 4
opt.termguicolors = true
opt.timeoutlen = 300
opt.undofile = true
opt.updatetime = 250
opt.virtualedit = 'block'
opt.wildmode = 'longest:full,full'
opt.winminwidth = 5
opt.wrap = false
opt.fillchars:append({ eob = ' ' })

-- Emacs-inspired settings
opt.timeout = true
opt.ttimeout = true
opt.ttimeoutlen = 10  -- Faster key sequence timeout

-- Disable builtin plugins
local disabled_built_ins = {
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logipat',
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'matchit',
  'tar',
  'tarPlugin',
  'rrhelper',
  'spellfile_plugin',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin',
}

for _, plugin in pairs(disabled_built_ins) do
  g['loaded_' .. plugin] = 1
end
```

**3. core/keymaps.lua** (Enhanced with Emacs-inspired keymaps)
```lua
local map = vim.keymap.set
local cmd = vim.cmd
local opts = { noremap = true, silent = true }

-- Leader keys (Doom Emacs style)
g.mapleader = ' '
g.maplocalleader = ','

-- Basic navigation (Emacs style)
map('i', '<C-a>', '<Home>', opts)
map('i', '<C-e>', '<End>', opts)
map('i', '<C-f>', '<Right>', opts)
map('i', '<C-b>', '<Left>', opts)
map('i', '<C-n>', '<Down>', opts)
map('i', '<C-p>', '<Up>', opts)
map('i', '<C-d>', '<Del>', opts)
map('i', '<C-k>', '<C-o>D', opts)

-- Zap to char (Emacs M-z)
map('n', '<leader>z', function()
  local char = vim.fn.input('Zap to char: ')
  if char ~= '' then
    vim.cmd('normal! f'..char..'vt'..char)
  end
end, { desc = 'Zap to char' })

-- Emacs M-x command
map('n', '<M-x>', function()
  require('telescope.builtin').commands(require('telescope.themes').get_dropdown())
end, { desc = 'Execute command (M-x)' })

-- Window navigation
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- Buffer management
map('n', '<leader>bd', '<cmd>Bdelete!<cr>', opts)
map('n', '<leader>bn', '<cmd>bnext<cr>', opts)
map('n', '<leader>bp', '<cmd>bprevious<cr>', opts)

-- Doom Emacs inspired keybindings
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find file' })
map('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', { desc = 'Recent files' })
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'Buffers' })
map('n', '<leader>fc', '<cmd>e $MYVIMRC<cr>', { desc = 'Edit config' })
map('n', '<leader>fs', '<cmd>w<cr>', { desc = 'Save file' })
map('n', '<leader>fS', '<cmd>wa<cr>', { desc = 'Save all' })
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit' })
map('n', '<leader>tt', '<cmd>ToggleTerm<cr>', { desc = 'Toggle terminal' })

-- Project navigation
map('n', '<leader>pp', '<cmd>Telescope project<cr>', { desc = 'Projects' })
map('n', '<leader>pf', '<cmd>Telescope find_files<cr>', { desc = 'Find file in project' })

-- Code actions
map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
map('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename symbol' })
map('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Diagnostics' })
```

**4. core/autocmds.lua**
```lua
local group = vim.api.nvim_create_augroup('UserConfig', {})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = group,
  callback = function()
    vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
  end
})

-- Auto-create dir when saving
vim.api.nvim_create_autocmd('BufWritePre', {
  group = group,
  callback = function(ctx)
    local dir = vim.fn.expand('<afile>:p:h')
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end
})

-- Filetype-specific settings
vim.api.nvim_create_autocmd('FileType', {
  group = group,
  pattern = { 'markdown', 'tex', 'text' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
    vim.opt_local.conceallevel = 2
  end
})

-- Close some filetypes with q
vim.api.nvim_create_autocmd('FileType', {
  group = group,
  pattern = {
    'qf', 'help', 'man', 'notify', 'lspinfo', 'spectre_panel', 'startuptime',
    'tsplayground', 'PlenaryTestPopup', 'checkhealth', 'neotest-output',
    'neotest-summary', 'neotest-output-panel'
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end
})

-- Auto-resize splits
vim.api.nvim_create_autocmd('VimResized', {
  group = group,
  callback = function()
    vim.cmd('tabdo wincmd =')
  end
})

-- Enable autocompletion for command mode (Emacs M-x style)
vim.api.nvim_create_autocmd('CmdlineEnter', {
  group = group,
  callback = function()
    local cmdline = vim.fn.getcmdline()
    if cmdline:sub(1, 1) == ':' then
      vim.cmd('set wildmenu')
      vim.cmd('set wildchar=<Tab>')
    end
  end
})
```

**5. core/colorscheme.lua**
```lua
local M = {}

function M.setup()
  require('catppuccin').setup({
    flavour = 'mocha',
    transparent_background = vim.g.transparent_enabled,
    integrations = {
      aerial = true,
      alpha = true,
      cmp = true,
      dashboard = true,
      flash = true,
      gitsigns = true,
      headlines = true,
      illuminate = true,
      indent_blankline = { enabled = true },
      leap = true,
      lsp_trouble = true,
      mason = true,
      markdown = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { 'italic' },
          hints = { 'italic' },
          warnings = { 'italic' },
          information = { 'italic' },
        },
        underlines = {
          errors = { 'underline' },
          hints = { 'underline' },
          warnings = { 'underline' },
          information = { 'underline' },
        },
        inlay_hints = {
          background = true,
        },
      },
      navic = { enabled = true, custom_bg = 'lualine' },
      neotest = true,
      neotree = true,
      noice = true,
      notify = true,
      semantic_tokens = true,
      telescope = {
        enabled = true,
        style = 'nvchad',
      },
      treesitter = true,
      treesitter_context = true,
      which_key = true,
      dap = { enabled = true, enable_ui = true },
    },
  })

  vim.cmd.colorscheme('catppuccin')
end

return M
```

### Plugin Modules
**1. plugins/jupyter.lua** (Using Molten.nvim)
```lua
return {
  -- Jupyter integration
  { 'benlubas/molten-nvim',
    build = ':UpdateRemotePlugins',
    ft = { 'python', 'julia' },
    dependencies = { '3rd/image.nvim' },
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
    end,
    config = function()
      require('image').setup({ backend = 'kitty' })

      vim.keymap.set('n', '<leader>mi', '<cmd>MoltenInit<cr>', { desc = 'Init Molten' })
      vim.keymap.set('n', '<leader>me', '<cmd>MoltenEvaluateOperator<cr>', { desc = 'Evaluate Operator' })
      vim.keymap.set('n', '<leader>ml', '<cmd>MoltenEvaluateLine<cr>', { desc = 'Evaluate Line' })
      vim.keymap.set('v', '<leader>mr', '<cmd><C-u>MoltenEvaluateVisual<cr>', { desc = 'Evaluate Visual' })
      vim.keymap.set('n', '<leader>md', '<cmd>MoltenDelete<cr>', { desc = 'Delete Output' })
      vim.keymap.set('n', '<leader>mo', '<cmd>MoltenShowOutput<cr>', { desc = 'Show Output' })
      vim.keymap.set('n', '<leader>mr', '<cmd>MoltenReevaluateCell<cr>', { desc = 'Re-evaluate Cell' })
    end
  },

  -- Virtual environments
  { 'ChristianChiarulli/swenv.nvim',
    ft = 'python',
    config = function()
      require('swenv').setup({
        get_venvs = function(venvs_path)
          return require('swenv.api').get_venvs(venvs_path)
        end,
        venvs_path = vim.fn.expand('~/.virtualenvs'),
      })
      vim.keymap.set('n', '<leader>sv', '<cmd>Swenv<cr>', { desc = 'Switch Env' })
    end
  },

  -- Jupyter notebook viewer
  { 'GCBallesteros/jupytext.nvim',
    config = true,
    ft = { 'python', 'markdown' },
    keys = {
      { '<leader>jp', '<cmd>Jupytext<cr>', desc = 'Jupytext' },
      { '<leader>jn', '<cmd>JupyterNotebook<cr>', desc = 'Open Notebook' },
    }
  },
}
```

**2. plugins/tex.lua** (Using tectonic)
```lua
return {
  -- LaTeX support with tectonic
  { 'lervag/vimtex',
    ft = 'tex',
    init = function()
      vim.g.vimtex_compiler_method = 'tectonic'
      vim.g.vimtex_compiler_tectonic = {
        options = {
          '--synctex',
          '--keep-logs',
          '--keep-intermediates',
        }
      }
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_syntax_conceal = {
        accents = 1,
        ligatures = 1,
        cites = 1,
        fancy = 1,
        spacing = 1,
        greek = 1,
        math_bounds = 0,
        math_delimiters = 1,
        math_fracs = 1,
        math_super_sub = 1,
        math_symbols = 1,
        sections = 0,
        styles = 1
      }
    end
  },

  -- Automatic table of contents
  { 'michaelb/sniprun', run = 'bash ./install.sh' },

  -- Better conceal for LaTeX
  { 'jbyuki/nabla.nvim',
    ft = 'tex',
    config = function()
      vim.keymap.set('n', '<leader>np', function() require('nabla').popup() end, { desc = 'Preview Math' })
    end
  },

  -- Live preview
  { 'xuhdev/vim-latex-live-preview',
    ft = 'tex',
    init = function()
      vim.g.livepreview_previewer = 'zathura'
      vim.g.livepreview_engine = 'tectonic'
      vim.keymap.set('n', '<leader>lp', '<cmd>LLPStartPreview<cr>', { desc = 'Live Preview' })
    end
  },
}
```

**3. plugins/astronvim.lua** (Astronvim community plugins)
```lua
return {
  -- Community plugins from Astronvim
  { 'AstroNvim/astrocommunity',
    dependencies = { 'AstroNvim/astrocore' },
    config = function()
      -- Import community plugins
      require('astrocommunity').setup({
        { import = 'astrocommunity.pack.lua' },
        { import = 'astrocommunity.pack.python' },
        { import = 'astrocommunity.pack.markdown' },
        { import = 'astrocommunity.pack.json' },
        { import = 'astrocommunity.pack.yaml' },
        { import = 'astrocommunity.pack.bash' },
        { import = 'astrocommunity.pack.rust' },
        { import = 'astrocommunity.pack.cpp' },
        { import = 'astrocommunity.pack.typescript' },
        { import = 'astrocommunity.pack.html-css' },
        { import = 'astrocommunity.editing-support.nvim-regexplainer' },
        { import = 'astrocommunity.editing-support.todo-comments-nvim' },
        { import = 'astrocommunity.editing-support.ultimate-autopair-nvim' },
        { import = 'astrocommunity.motion.nvim-spider' },
        { import = 'astrocommunity.motion.flash-nvim' },
        { import = 'astrocommunity.color.tint-nvim' },
      })
    end
  },

  -- Emacs which-key alternative
  { 'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      require('which-key').setup({
        plugins = { spelling = true },
        window = {
          border = 'rounded',
          position = 'bottom',
          margin = { 1, 0, 1, 0 },
        },
        layout = {
          height = { min = 4, max = 25 },
          spacing = 3,
          align = 'center',
        },
        ignore_missing = true,
        hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' },
        triggers_blacklist = {
          i = { 'j', 'k' },
          v = { 'j', 'k' },
        },
      })
    end
  },

  -- Emacs execute-extended-command
  { 'LinArcX/telescope-command-palette.nvim',
    dependencies = 'nvim-telescope/telescope.nvim',
    config = function()
      require('telescope').load_extension('command_palette')
      vim.keymap.set('n', '<M-x>', '<cmd>Telescope command_palette<cr>', { desc = 'Command Palette' })
    end
  },
}
```

**4. plugins/navigation.lua** (Enhanced with Emacs features)
```lua
return {
  -- File explorer (Doom Emacs style)
  { 'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      { '<leader>fe', '<cmd>Neotree toggle<cr>', desc = 'File Explorer' },
    },
    config = function()
      require('neo-tree').setup({
        close_if_last_window = true,
        popup_border_style = 'rounded',
        enable_git_status = true,
        enable_diagnostics = true,
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
          },
          follow_current_file = { enabled = true },
          hijack_netrw_behavior = 'open_current',
        },
        window = {
          position = 'left',
          width = 35,
          mappings = {
            ['<space>'] = 'none',
            ['o'] = 'open',
            ['h'] = 'close_node',
            ['l'] = 'open',
          },
        },
        default_component_configs = {
          icon = {
            folder_closed = '',
            folder_open = '',
            folder_empty = '',
          },
          modified = { symbol = '' },
          git_status = {
            symbols = {
              added = '',
              modified = '',
              deleted = '',
              renamed = '➜',
              untracked = '★',
              ignored = '◌',
              unstaged = '✗',
              staged = '✓',
              conflict = '',
            },
          },
        },
      })
    end
  },

  -- Fuzzy finder with Emacs helm-like interface
  { 'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'LinArcX/telescope-command-palette.nvim',
      'debugloop/telescope-undo.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',
    },
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
      { '<leader>fg', '<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<cr>', desc = 'Live Grep' },
      { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
      { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Help Tags' },
      { '<leader>fp', '<cmd>Telescope project<cr>', desc = 'Projects' },
      { '<leader>fu', '<cmd>Telescope undo<cr>', desc = 'Undo Tree' },
      { '<leader>fc', '<cmd>Telescope command_palette<cr>', desc = 'Command Palette' },
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      local lga_actions = require('telescope-live-grep-args.actions')

      telescope.setup({
        defaults = {
          prompt_prefix = '   ',
          selection_caret = '  ',
          entry_prefix = '  ',
          initial_mode = 'insert',
          selection_strategy = 'reset',
          path_display = { 'truncate' },
          layout_config = {
            horizontal = { prompt_position = 'top', preview_width = 0.55 },
            vertical = { mirror = false },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          mappings = {
            i = {
              ['<C-n>'] = actions.cycle_history_next,
              ['<C-p>'] = actions.cycle_history_prev,
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<esc>'] = actions.close,
            },
            n = { ['q'] = actions.close },
          },
        },
        pickers = {
          find_files = { theme = 'dropdown' },
          live_grep = { theme = 'dropdown' },
          buffers = { theme = 'dropdown' },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          },
          live_grep_args = {
            auto_quoting = true,
            mappings = {
              i = {
                ['<C-k>'] = lga_actions.quote_prompt(),
                ['<C-i>'] = lga_actions.quote_prompt({ postfix = ' --iglob ' }),
              },
            },
          },
          command_palette = {
            { 'File',
              { 'entire selection (C-a)', ':call feedkeys("GVgg")' },
              { 'save current file (C-s)', ':w' },
              { 'save all files (C-S-s)', ':wa' },
              { 'quit (C-q)', ':qa' },
              { 'file browser (C-b)', ':lua require("telescope").extensions.file_browser.file_browser()', 1 },
              { 'search word (A-s)', ':lua require("telescope.builtin").live_grep()', 1 },
              { 'git files (A-f)', ':lua require("telescope.builtin").git_files()', 1 },
              { 'files (A-F)', ':lua require("telescope.builtin").find_files()', 1 },
            },
            { 'Help',
              { 'tips', ':help tips' },
              { 'cheatsheet', ':help index' },
              { 'tutorial', ':help tutor' },
              { 'summary', ':help summary' },
              { 'quick reference', ':help quickref' },
              { 'search help(F1)', ':lua require("telescope.builtin").help_tags()', 1 },
            },
            { 'Vim',
              { 'reload vimrc', ':source $MYVIMRC' },
              { 'check health', ':checkhealth' },
              { 'jumps (Alt-j)', ':lua require("telescope.builtin").jumplist()' },
              { 'commands', ':lua require("telescope.builtin").commands()' },
              { 'command history', ':lua require("telescope.builtin").command_history()' },
              { 'registers (A-e)', ':lua require("telescope.builtin").registers()' },
              { 'colorscheme', ':lua require("telescope.builtin").colorscheme()', 1 },
              { 'vim options', ':lua require("telescope.builtin").vim_options()' },
              { 'keymaps', ':lua require("telescope.builtin").keymaps()' },
              { 'buffers', ':Telescope buffers' },
            }
          }
        },
      })

      telescope.load_extension('fzf')
      telescope.load_extension('project')
      telescope.load_extension('undo')
      telescope.load_extension('command_palette')
      telescope.load_extension('live_grep_args')
    end
  },

  -- Emacs-style navigation
  { 'chrisgrieser/nvim-spider',
    keys = {
      { 'w', "<cmd>lua require('spider').motion('w')<CR>", mode = { 'n', 'o', 'x' } },
      { 'e', "<cmd>lua require('spider').motion('e')<CR>", mode = { 'n', 'o', 'x' } },
      { 'b', "<cmd>lua require('spider').motion('b')<CR>", mode = { 'n', 'o', 'x' } },
    }
  },

  -- Zap to char implementation
  { 'max397574/better-escape.nvim',
    event = 'InsertEnter',
    config = function()
      require('better_escape').setup({
        mapping = { 'jk', 'jj' },
        timeout = 300,
        clear_empty_lines = true,
      })
    end
  },
}
```

**5. plugins/util.lua** (Doom Emacs inspired features)
```lua
return {
  -- Session management
  { 'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = { options = { 'buffers', 'curdir', 'tabpages', 'winsize' } },
    keys = {
      { '<leader>qs', function() require('persistence').load() end, desc = 'Restore Session' },
      { '<leader>ql', function() require('persistence').load({ last = true }) end, desc = 'Restore Last Session' },
    },
  },

  -- Git integration (Magit-like)
  { 'TimUntersberger/neogit',
    cmd = 'Neogit',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require('neogit').setup({
        integrations = { diffview = true },
        disable_commit_confirmation = true,
      })
      vim.keymap.set('n', '<leader>gg', '<cmd>Neogit<cr>', { desc = 'Neogit (Magit)' })
    end
  },

  -- Emacs modeline
  { 'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = function()
      local function show_macro_recording()
        local recording_register = vim.fn.reg_recording()
        if recording_register == "" then
          return ""
        else
          return "Recording @" .. recording_register
        end
      end

      return {
        options = {
          theme = 'catppuccin',
          globalstatus = true,
          disabled_filetypes = { statusline = { 'dashboard', 'alpha' } },
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { { 'filename', path = 1 } },
          lualine_x = { show_macro_recording, 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
        extensions = { 'neo-tree', 'lazy' },
      }
    end
  },

  -- Emacs modeline
  { 's1n7ax/nvim-window-picker',
    config = function()
      require('window-picker').setup({
        filter_rules = {
          include_current_win = false,
          autoselect_one = true,
          bo = {
            filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
            buftype = { 'terminal', 'quickfix' },
          },
        },
      })
      vim.keymap.set('n', '<C-w>p', function()
        local window_number = require('window-picker').pick_window()
        if window_number then vim.api.nvim_set_current_win(window_number) end
      end, { desc = 'Pick window' })
    end
  },

  -- Doom Emacs modeline
  { 'b0o/incline.nvim',
    config = function()
      require('incline').setup({
        window = {
          padding = 0,
          margin = { horizontal = 0 },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
          local icon, color = require('nvim-web-devicons').get_icon_color(filename)
          return {
            { ' ' },
            { icon, guifg = color },
            { ' ' },
            { filename },
            { ' ' },
          }
        end,
      })
    end
  },
}
```

### Key Enhancements:
1. **Molten.nvim for Jupyter**:
   - Replaced magma.nvim with Molten for better kernel management
   - Image display support with image.nvim
   - Cell execution and output management

2. **Tectonic for LaTeX**:
   - Modern LaTeX engine with better dependency management
   - Live preview integration
   - Faster compilation times

3. **Emacs-inspired Features**:
   - `M-x` command palette with telescope-command-palette
   - Zap-to-char navigation
   - Emacs-style keybindings (C-a, C-e, C-f, etc.)
   - Modeline with recording indicator
   - Window picker for Emacs-like window navigation

4. **Doom Emacs Elements**:
   - Magit-like interface with neogit
   - Project-centric workflow
   - Unified command palette
   - Consistent keybinding scheme
   - Session management

5. **Astronvim Community Plugins**:
   - Language packs for better out-of-box experience
   - Enhanced editing utilities
   - Advanced motion plugins
   - Additional color utilities

6. **Catppuccin Mocha Theme**:
   - Full integration across all UI components
   - Custom highlights for new plugins
   - Consistent color scheme throughout

### Setup Instructions:
1. Install dependencies:
```bash
# Python
pip install pynvim debugpy jupyter jupytext

# LaTeX
cargo install tectonic
sudo apt install zathura

# Node.js
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

# Rust (for tree-sitter)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Image support for Jupyter
sudo apt install imagemagick
```

2. Clone the configuration:
```bash
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
```

3. Start Neovim and let plugins install automatically

4. Enable Emacs mode in your config (add to init.lua):
```lua
vim.g.emacs_mode = true
```

This configuration combines the power of modern Neovim with the workflow efficiency of Emacs and Doom Emacs, while maintaining a visually appealing Catppuccin Mocha theme throughout. The setup provides a comprehensive IDE-like experience with specialized tools for Jupyter, LaTeX, and general programming.
