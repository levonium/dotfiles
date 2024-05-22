local separator = { '"| "', color = 'StatusLineNonText' }

require('lualine').setup({
    options = {
        section_separators = '',
        component_separators = '',
        globalstatus = true,
        theme = {
            normal = {
                a = 'StatusLine',
                b = 'StatusLine',
                c = 'StatusLine',
            },
        },
    },
    sections = {
        lualine_a = {
            'mode',
            separator,
        },
        lualine_b = {
            'branch',
            {
                'diff',
                symbols = { added = ' ', modified = ' ', removed = ' ' },
            },
            function ()
                return '󰅭 ' .. vim.pesc(tostring(#vim.tbl_keys(vim.lsp.buf_get_clients())) or '')
            end,
            { 'diagnostics', sources = { 'nvim_diagnostic' } },
        },
        lualine_c = {
            'filename'
        },
        lualine_x = {
            {
                'filetype',
                'encoding',
                'fileformat',
            },
        },
        lualine_y = {
            '(vim.bo.expandtab and "␠ " or "⇥ ") .. vim.bo.shiftwidth',
        },
        lualine_z = {
            'searchcount',
            'selectioncount',
            'location',
            'progress',
        },
    },
})
