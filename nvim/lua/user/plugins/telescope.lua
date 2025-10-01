local actions = require('telescope.actions')

require('telescope').setup({
    defaults = {
        path_display = { truncate = 1 },
        prompt_prefix = '   ',
        selection_caret = '  ',
        layout_config = {
            prompt_position = 'top',
        },
        preview = {
            timeout = 200,
        },
        sorting_strategy = 'ascending',
        mappings = {
            i = {
                ['<esc>'] = actions.close,
                ['<A-Down>'] = actions.cycle_history_next,
                ['<A-Up>'] = actions.cycle_history_prev,
            },
        },
        file_ignore_patterns = { '.git/' },
    },
    extensions = {
        live_grep_args = {
            mappings = {
                i = {
                    ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
                    ["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob " }),
                },
            },
        },
    },
    pickers = {
        find_files = {
            hidden = true,
        },
        buffers = {
            previewer = false,
            layout_config = {
                width = 80,
            },
        },
        oldfiles = {
            prompt_title = 'History',
        },
        lsp_references = {
            previewer = false,
        },
        lsp_definitions = {
            previewer = false,
        },
        lsp_document_symbols = {
            symbol_width = 55,
        },
    },
})

require('telescope').load_extension('fzf')

vim.keymap.set('n', '<C-p>', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
vim.keymap.set('n', '<C-p-p>',
    [[<cmd>lua require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'All Files' })<CR>]])
vim.keymap.set('n', '<C-e>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
vim.keymap.set('n', '<C-f>', [[<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>]])
