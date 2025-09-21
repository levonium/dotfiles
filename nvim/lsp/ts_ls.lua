local util = require("lspconfig.util")

return {
  cmd = { "typescript-language-server", "--stdio" },
  root_dir = function(fname)
    return util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")(fname)
        or util.path.dirname(fname)
        or vim.loop.cwd()
  end,
  single_file_support = true,
}
