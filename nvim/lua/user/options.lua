vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wildmode = 'longest:full,full'

vim.opt.title = true
vim.opt.mouse = 'a'

vim.opt.termguicolors = true

vim.opt.spell = true

vim.opt.ignorecase = true
vim.smartcase = true

vim.opt.list = true
vim.opt.listchars = { tab = '‣ ', trail = '·' }
vim.opt.fillchars:append({ eob = ' ' }) -- remove ~

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scrolloff = 6
vim.opt.sidescrolloff = 6

vim.opt.clipboard = 'unnamedplus' -- use system clipboard

vim.opt.confirm = true -- ask for confirmation instead of an error

vim.opt.undofile = true -- persistent undo
vim.opt.backup = true -- automatically save a backup file
vim.opt.backupdir:remove('.') -- keep backups out of the current directory
