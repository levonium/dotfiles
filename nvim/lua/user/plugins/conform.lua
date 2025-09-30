local ok, conform = pcall(require, 'conform')
if not ok then
  return
end

conform.setup({
  -- Try project tools first; fall back to LSP formatting
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return nil
    end
    -- Disable for large files (>500KB)
    local max = 500 * 1024
    local ok_stat, stat = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
    if ok_stat and stat and stat.size and stat.size > max then
      return nil
    end
    return { lsp_fallback = true, timeout_ms = 2000 }
  end,

  -- Map filetypes to preferred formatters (first available wins)
  formatters_by_ft = {
    javascript = { 'prettierd', 'prettier' },
    javascriptreact = { 'prettierd', 'prettier' },
    typescript = { 'prettierd', 'prettier' },
    typescriptreact = { 'prettierd', 'prettier' },
    vue = { 'prettierd', 'prettier' },
    svelte = { 'prettierd', 'prettier' },
    css = { 'prettierd', 'prettier' },
    scss = { 'prettierd', 'prettier' },
    less = { 'prettierd', 'prettier' },
    json = { 'prettierd', 'prettier' },
    jsonc = { 'prettierd', 'prettier' },
    yaml = { 'prettierd', 'prettier' },
    markdown = { 'prettierd', 'prettier', 'mdformat' },
    lua = { 'stylua' },
    php = { 'pint', 'php_cs_fixer' },
    sh = { 'shfmt' },
  },

  -- Formatter definitions and local-preference
  formatters = {
    -- Prefer project-local installs
    prettier = { prefer_local = 'node_modules/.bin' },
    prettierd = { prefer_local = 'node_modules/.bin' },

    mdformat = {
      command = 'mdformat',
      args = { '--wrap', '80', '$FILENAME' },
      stdin = false,
      tempfile_postfix = '.md',
    },

    -- PHP formatters typically format files in-place
    pint = {
      command = 'pint',
      args = { '--quiet', '$FILENAME' },
      stdin = false,
      prefer_local = 'vendor/bin',
    },
    php_cs_fixer = {
      command = 'php-cs-fixer',
      args = { 'fix', '--using-cache=no', '--quiet', '$FILENAME' },
      stdin = false,
      prefer_local = 'vendor/bin',
    },
  },
})

-- Optional keymap to format manually
vim.keymap.set('n', '<leader>f', function()
  conform.format({ async = true, lsp_fallback = true })
end, { desc = 'Format buffer' })
