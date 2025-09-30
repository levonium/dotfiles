-- Ensure mason and mason-lspconfig are loaded first
require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",   -- Lua
    "ts_ls",    -- JavaScript / TypeScript
    "cssls",    -- CSS
    "phpactor", -- PHP
    "bashls"    -- Bash
  },
  automatic_installation = true,
  -- Prevent mason-lspconfig from calling vim.lsp.enable(),
  -- so we fully control startup via lspconfig.setup.
  automatic_enable = false,
})

-- Use the new vim.lsp.enable() API for Neovim 0.11+
-- The old require('lspconfig') framework is deprecated

-- Capabilities (enhanced if nvim-cmp is installed)
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
  capabilities = cmp_lsp.default_capabilities(capabilities)
end

-- Enable LSP servers using the new API
vim.lsp.enable("lua_ls", {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.enable("ts_ls", {
  capabilities = capabilities,
  single_file_support = true,
})

vim.lsp.enable("cssls", { capabilities = capabilities })

vim.lsp.enable("phpactor", { capabilities = capabilities })

vim.lsp.enable("bashls", { capabilities = capabilities })
