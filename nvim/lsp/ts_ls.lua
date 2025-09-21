-- Custom TypeScript/JavaScript LSP configuration
-- This file extends the built-in ts_ls config with custom settings
return {
  cmd = { "typescript-language-server", "--stdio" },
  root_dir = function(fname)
    local util = require("lspconfig.util")
    return util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")(fname)
        or util.path.dirname(fname)
        or vim.loop.cwd()
  end,
  single_file_support = true,
}
