local cmp = require('cmp')
local luasnip_ok, luasnip = pcall(require, 'luasnip')

if luasnip_ok then
  -- Lazy load friendly snippets if the loader is available
  local ok_loader, loader = pcall(require, 'luasnip.loaders.from_vscode')
  if ok_loader and loader and loader.lazy_load then
    loader.lazy_load()
  end
end

cmp.setup({
  snippet = {
    expand = function(args)
      if luasnip_ok then
        luasnip.lsp_expand(args.body)
      end
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip_ok and luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip_ok and luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    luasnip_ok and { name = 'luasnip' } or nil,
  }, {
    { name = 'path' },
    { name = 'buffer' },
  }),
  preselect = cmp.PreselectMode.Item,
  completion = { completeopt = 'menu,menuone,noinsert' },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})
