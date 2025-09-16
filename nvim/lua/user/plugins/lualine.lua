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
            function()
                local bufnr = vim.api.nvim_get_current_buf()
                local ok, clients = pcall(vim.lsp.get_clients, { bufnr = bufnr })
                if not ok then
                    clients = vim.lsp.get_active_clients({ bufnr = bufnr })
                end
                local count = (type(clients) == "table") and #clients or 0
                return "󰅭 " .. tostring(count)
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
            function()
                return (vim.bo.expandtab and "␠ " or "⇥ ") .. vim.bo.shiftwidth
            end,
        },
        lualine_z = {
            'searchcount',
            'selectioncount',
            'location',
            'progress',
        },
    },
})
