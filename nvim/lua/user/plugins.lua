local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

require('packer').reset()
require('packer').init({
    compile_path = vim.fn.stdpath('data') .. '/site/plugin/packer_compiled.lua',
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'solid' })
        end,
    },
})

local use = require('packer').use

-- Packer to manage itself.
use('wbthomason/packer.nvim')

-- Colorscheme
use({
    'folke/tokyonight.nvim',
    config = function()
        require('tokyonight').setup({
            transparent = true,
            styles = {
                sidebars = 'transparent',
                floats = 'transparent',
            },
        })

        vim.cmd('colorscheme tokyonight')

        local function get_hl(name)
            local ok, hl = pcall(vim.api.nvim_get_hl_by_name, name, true)
            if not ok then
                return {}
            end
            return hl
        end

        local function make_transparent(group)
            vim.api.nvim_set_hl(0, group, { bg = 'NONE' })
        end

        local normal = get_hl('Normal')
        local normal_float = get_hl('NormalFloat')
        local float_border = get_hl('FloatBorder')

        make_transparent('Normal')
        make_transparent('NormalFloat')
        make_transparent('SignColumn')
        make_transparent('EndOfBuffer')
        local float_border_fg = float_border.foreground or normal_float.foreground or normal.foreground
        local float_border_opts = { bg = 'NONE' }

        if float_border_fg then
            float_border_opts.fg = float_border_fg
        end

        vim.api.nvim_set_hl(0, 'FloatBorder', float_border_opts)

        vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { fg = '#30323E' })

        local non_text = get_hl('NonText')
        local status_line = get_hl('StatusLine')

        if non_text.foreground and status_line.background then
            vim.api.nvim_set_hl(0, 'StatusLineNonText', {
                fg = non_text.foreground,
                bg = status_line.background,
            })
        end
    end
})

-- Commenting support
use('tpope/vim-commentary')

-- Add,change and delete surrounding text
use('tpope/vim-surround')

-- Useful commands like :Rename and :sudoWrite
use('tpope/vim-eunuch')

-- Pairs of handy bracket mappings, like [b and ]b
use('tpope/vim-unimpaired')

-- Indent autodetection with .editorconfig support
use('tpope/vim-sleuth')

-- Allow plugins to enable repeating commands (.)
use('tpope/vim-repeat')

-- Just to the last location when opening a file
use('farmergreg/vim-lastplace')

-- Enable search for visually selected text
use('nelstrom/vim-visual-star-search')

-- Automatically create parent missing dirs when saving
use('jessarcher/vim-heritage')

-- Text objects for HTML attributes
use({
    'whatyouhide/vim-textobj-xmlattr',
    requires = 'kana/vim-textobj-user',
})

-- automatically set the working directory to the project root
use({
    'airblade/vim-rooter',
    setup = function()
        vim.g.rooter_manual_only = 1
    end,
    config = function()
        vim.cmd('Rooter')
    end
})

-- Automatically add closing brackets, quotes, etc.
use({
    'windwp/nvim-autopairs',
    config = function()
        require('nvim-autopairs').setup()
    end
})

-- Easy navigation between vim and tmux panes
use('christoomey/vim-tmux-navigator')

-- Add smooth scrolling
-- use({
--     'karb94/neoscroll.nvim',
--     config = function()
--         require('neoscroll').setup()
--     end
-- })

-- Split arrays and methods onto multiple lines, or join them back
use({
    'AndrewRadev/splitjoin.vim',
    config = function()
        vim.g.splitjoin_html_attributes_brackets_on_new_line = 1
        vim.g.splitjoin_trailing_comma = 1
        vim.g.splitjoin_php_method_chain_full = 1
    end
})

-- Automatically fix the indentation when pasting
use({
    'sickill/vim-pasta',
    config = function()
        vim.g.pasta_disabled_filetypes = { 'fugitive' }
    end
})

-- Fuzzy finder
use({
    'nvim-telescope/telescope.nvim',
    requires = {
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
        'nvim-telescope/telescope-live-grep-args.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
    config = function()
        require('user/plugins/telescope')
    end
})

-- File Tree sidebar
use({
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
        require('user/plugins/nvim-tree')
    end
})

-- Status line
use({
    'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
        require('user/plugins/lualine')
    end
})

-- Buffer tabs
use({
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    after = 'tokyonight.nvim',
    config = function()
        require('user/plugins/bufferline')
    end
})

-- Display indentation lines
-- use({
--     'lukas-reineke/indent-blankline.nvim',
--     config = function()
--         require('indent_blankline').setup()
--     end
-- })

-- Dashboard
-- use({
--     'glepnir/dashboard-nvim'
-- })

-- Git integration
use({
    'lewis6991/gitsigns.nvim',
    config = function()
        require('gitsigns').setup({
            current_line_blame = true
        })
        vim.keymap.set('n', ']h', ':Gitsigns next_hunk<CR>')
        vim.keymap.set('n', '[h', ':Gitsigns prev_hunk<CR>')
        vim.keymap.set('n', 'gs', ':Gitsigns stage_hunk<CR>')
        vim.keymap.set('n', 'gS', ':Gitsigns undo_stage_hunk<CR>')
        vim.keymap.set('n', 'gp', ':Gitsigns preview_hunk<CR>')
        vim.keymap.set('n', 'gb', ':Gitsigns blame_line<CR>')
    end
})

use({
    'tpope/vim-fugitive',
    requires = 'tpope/vim-rhubarb'
})

-- Floating terminal.
use({
    'voldikss/vim-floaterm',
    config = function()
        vim.g.floaterm_wintype = 'split'
        vim.g.floaterm_height = 0.4
        vim.keymap.set('n', '<leader><leader>', ':FloatermToggle<CR>')
        vim.keymap.set('t', '<F1>', '<C-\\><C-n>:FloatermToggle<CR>')
    end
})

-- Formatting on save
use({
    'stevearc/conform.nvim',
    config = function()
        require('user/plugins/conform')
    end
})

-- Completion
use({
    'hrsh7th/nvim-cmp',
    requires = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
    },
    config = function()
        require('user/plugins/cmp')
    end
})

-- LSP Config
use {
    "neovim/nvim-lspconfig",
    requires = {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
        require('user/plugins/lspconfig')
    end,
}


-- Tree Sitter
use({
    'nvim-treesitter/nvim-treesitter',
    run = function()
        require('nvim-treesitter.install').update({ with_sync = true })
    end,
    rewuires = {
        'JooepAlviste/nvim-ts-context-commentstring',
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
        require('user/plugins/treesitter')
    end,
})

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if packer_bootstrap then
    require('packer').sync()
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile>
  augroup end
]])
