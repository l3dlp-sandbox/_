require'nvim-autopairs'.setup{}
require'colorizer'.setup{}
require'gitsigns'.setup{}
require'lualine'.setup{
  options = {
    theme = 'nord',
    icons_enabled = false,
  },
}

require'nvim-treesitter.configs'.setup{
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}

require'lspconfig'.bashls.setup { on_attach = require'completion'.on_attach, }
require'lspconfig'.dockerls.setup { on_attach = require'completion'.on_attach, }
require'lspconfig'.omnisharp.setup { on_attach = require'completion'.on_attach, }
require'lspconfig'.rnix.setup { on_attach = require'completion'.on_attach, }
require'lspconfig'.solargraph.setup { on_attach = require'completion'.on_attach, }
require'lspconfig'.terraformls.setup { on_attach = require'completion'.on_attach, }
require'lspconfig'.tsserver.setup { on_attach = require'completion'.on_attach, }
require'lspconfig'.gopls.setup {
  on_attach = require'completion'.on_attach,
  analyses = {
    unusedparams = true,
    staticcheck = true,
  },
}

local wk = require'which-key'

wk.register({
  f = {
    name = "file",
    e = { "<cmd>Explore<cr>", "File Explorer" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    n = { "<cmd>enew<cr>", "New File" },
    r = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
  },
  l = {
    name = "lsp",
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format Buffer" },
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Actions" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    d = {
      name = "diagnostics",
      n = { "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>", "Next Diagnostic" },
      p = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", "Previous Diagnostic" },
      h = { "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", "Line Diagnostics" },
    },
  },
  t = {
    name = "tabs",
    t = { "<cmd>tabnew<cr>", "New Tab" },
    n = { "<cmd>tabnext<cr>", "Next Tab" },
    p = { "<cmd>tabprevious<cr>", "Previous Tab" },
  },
  c = {
    name = "quickfix",
    n = { "<cmd>cnext<cr>", "Next Item" },
    p = { "<cmd>cprev<cr>", "Previous Item" },
    q = { "<cmd>cclose<cr>", "Close List" },
    o = { "<cmd>copen<cr>", "Open List" },
  },
  g = {
    name = "git",
    b = { "<cmd>Gitsigns blame_line<cr>", "Blame Line" },
    h = {
      name = "hunk",
      r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },
      s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk" },
      n = { "<cmd>Gitsigns next_hunk<cr>", "Next Hunk" },
      p = { "<cmd>Gitsigns prev_hunk<cr>", "Previous Hunk" },
    },
  },
  s = {
    name = "search",
    r = { ":%s//g<left><left>", "Replace" }
  },
  q = { "<cmd>q<cr>", "Quit" },
  w = { "<cmd>w<cr>", "Save" },
  p = { "<cmd>\"*p<cr>", "Paste" },
  y = { "<cmd>\"*y<cr>", "Copy" },
}, { prefix = "<leader>" })

wk.register({
  K = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
  g = {
    d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto Definition" },
    r = { "<cmd>lua vim.lsp.buf.references()<cr>", "Goto References" },
  },
  ["<bs>"] = { "-", "Back" },
})

wk.register({
  ["<"] = { "<gv", "Dedent" },
  [">"] = { ">gv", "Indent" },
  S = { ":s//g<left><left>", "Replace" },
  so = { ":sort <bar>w<bar>e<cr>", "Sort" }
}, { mode = "v" })

wk.register({
  ["<expr> <s-tab>"] = "pumvisible() ? \"\\<C-p>\" : \"\\<S-Tab>\"",
  ["<expr> <tab>"] = "pumvisible() ? \"\\<C-n>\" : \"\\<Tab>\"",
}, { mode = "i" })

wk.setup {
  ignore_missing = false,
}
