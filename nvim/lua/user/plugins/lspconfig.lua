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
})

-- Load lspconfig
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

-- Lua language server
lspconfig.lua_ls.setup({
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
  root_dir = function(fname) return util.path.dirname(fname) end,
  single_file_support = true,
})

-- CSS
lspconfig.cssls.setup({})

-- PHP
lspconfig.phpactor.setup({})

-- Bash
lspconfig.bashls.setup({})
