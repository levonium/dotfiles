local THEME = {
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
            local ok, hl = pcall(vim.api.nvim_get_hl, name, true)
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
    end,
}

return THEME
