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

-- Load lspconfig
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

-- Capabilities (enhanced if nvim-cmp is installed)
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
  capabilities = cmp_lsp.default_capabilities(capabilities)
end

-- Lua language server
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = { checkThirdParty = false },
      diagnostics = { globals = { "vim" } },
    },
  },
})

-- JavaScript / TypeScript
lspconfig.ts_ls.setup({
  capabilities = capabilities,
  root_dir = function(fname)
    return util.root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git")(fname)
        or util.path.dirname(fname)
  end,
  single_file_support = true,
})

-- CSS
lspconfig.cssls.setup({ capabilities = capabilities })

-- PHP
lspconfig.phpactor.setup({ capabilities = capabilities })

-- Bash
lspconfig.bashls.setup({ capabilities = capabilities })
