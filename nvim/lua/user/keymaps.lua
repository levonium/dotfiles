-- Space is my leader.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Clear search highlighting.
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Close all open buffers.
vim.keymap.set('n', '<leader>Q', ':bufdo bdelete<CR>')

-- Diagnostics.
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [d]iagnostic' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [d]iagnostic' })

-- Allow gf to open non-existent files.
-- vim.keymap.set('', 'gf', ':edit <cfile><CR>')

-- Reselect visual selection after indenting.
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Maintain the cursor position when yanking a visual selection.
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set('v', 'y', 'myy`y')
vim.keymap.set('v', 'Y', 'myY`y')

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided.
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Paste replace visual selection without copying it.
vim.keymap.set('v', 'p', '"_dP')

-- Reselect pasted text
vim.keymap.set('n', 'p', 'p`[v`]')

-- Easy insertion of a trailing ; or , from insert mode.
vim.keymap.set('i', ';;', '<Esc>A;<Esc>')
vim.keymap.set('i', ',,', '<Esc>A,<Esc>')

-- Open the current file in the default program (on Mac this should just be just `open`).
vim.keymap.set('n', '<leader>x', ':!xdg-open %<cr><cr>')

-- Disable annoying command line thing.
vim.keymap.set('n', 'q:', ':q<CR>')

-- Resize with arrows.
-- vim.keymap.set('n', '<C-Up>', ':resize +2<CR>')
-- vim.keymap.set('n', '<C-Down>', ':resize -2<CR>')
-- vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>')
-- vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>')

-- Move text up and down
vim.keymap.set('i', '<A-Down>', '<Esc>:move .+1<CR>==gi')
vim.keymap.set('i', '<A-Up>', '<Esc>:move .-2<CR>==gi')
vim.keymap.set('n', '<A-Down>', ':move .+1<CR>==')
vim.keymap.set('n', '<A-Up>', ':move .-2<CR>==')
vim.keymap.set('v', '<A-Down>', ":move '>+1<CR>gv=gv")
vim.keymap.set('v', '<A-Up>', ":move '<-2<CR>gv=gv")

-- Duplicate a line, remove a line
vim.keymap.set('n', '<C-S-d>', "yyp")
vim.keymap.set('n', '<C-S-k>', "dd")
