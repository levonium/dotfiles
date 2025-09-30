vim.env.PATH = vim.fn.stdpath('data') .. '/mason/bin:' .. vim.env.PATH

if vim.tbl_islist then
  vim.tbl_islist = vim.islist
end

require('user/plugins')
require('user/options')
require('user/keymaps')
