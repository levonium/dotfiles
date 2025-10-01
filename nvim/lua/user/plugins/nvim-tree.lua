require('nvim-tree').setup({
    git = {
        ignore = true,
    },
    renderer = {
        group_empty = true,
        icons = {
            show = {
                folder_arrow = true,
            },
        },
        indent_markers = {
            enable = true
        },
    },
})

vim.keymap.set('n', '<leader>n', ':NvimTreeFindFileToggle<CR>')
