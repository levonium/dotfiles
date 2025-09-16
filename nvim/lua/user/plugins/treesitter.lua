require('nvim-treesitter.configs').setup({
    ensure_installed = {
        "lua", "vim", "bash", "python", "javascript", "php"
    },
    ignore_install = { "ipkg" },
    sync_install = false,          -- don't block on startup
    auto_install = false,          -- don't auto-install on buffer open
    highlight = {
        enable = true,
    },
    context_commentstring = {
        enable = true,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['if'] = '@function.inner',
                ['af'] = '@function.outer',
                ['ia'] = '@parameter.inner',
                ['aa'] = '@parameter.outer',
            },
        },
    },
})
