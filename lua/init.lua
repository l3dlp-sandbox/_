-- THIS FILE WAS AUTO-GENERATED
-- See fnl/init.fnl for source
local function autocmd()
  return vim.cmd("augroup AutoCmds\n  autocmd BufEnter *.nix set ft=nix\n  autocmd BufEnter *.lock set ft=json\n  autocmd BufEnter *.graphql set ft=graphql\n  autocmd BufWrite *.go lua vim.lsp.buf.formatting()\n  autocmd BufEnter *.norg hi clear Conceal | set nohlsearch | lua wkneorg()\n  autocmd CmdLineEnter : set nosmartcase\n  autocmd CmdLineLeave : set smartcase\n  autocmd TermOpen * setlocal nonumber nocursorline signcolumn=no\n  autocmd TermOpen * startinsert\n  augroup END")
end
vim.defer_fn(autocmd, 50)
local function lsp()
  local lsp0 = require("lspconfig")
  lsp0.bashls.setup({})
  lsp0.dockerls.setup({})
  lsp0.rnix.setup({})
  lsp0.solargraph.setup({})
  lsp0.sorbet.setup({})
  lsp0.terraformls.setup({})
  lsp0.tsserver.setup({})
  lsp0.texlab.setup({})
  lsp0.yamlls.setup({})
  return lsp0.gopls.setup({analyses = {staticcheck = true, unusedparams = true}, flags = {debounce_text_changes = 500}})
end
vim.defer_fn(lsp, 50)
local wk = require("which-key")
local _0_
do
  local prefix_0_ = "Telescope"
  local cmd_0_ = "find_files"
  _0_ = ("<cmd>" .. prefix_0_ .. " " .. cmd_0_ .. "<cr>")
end
local _1_
do
  local prefix_0_ = "Telescope"
  local cmd_0_ = "live_grep"
  _1_ = ("<cmd>" .. prefix_0_ .. " " .. cmd_0_ .. "<cr>")
end
local _2_
do
  local prefix_0_ = "Gitsigns"
  local cmd_0_ = "blame_line"
  _2_ = ("<cmd>" .. prefix_0_ .. " " .. cmd_0_ .. "<cr>")
end
local _3_
do
  local prefix_0_ = "Gitsigns"
  local cmd_0_ = "next_hunk"
  _3_ = ("<cmd>" .. prefix_0_ .. " " .. cmd_0_ .. "<cr>")
end
local _4_
do
  local prefix_0_ = "Gitsigns"
  local cmd_0_ = "prev_hunk"
  _4_ = ("<cmd>" .. prefix_0_ .. " " .. cmd_0_ .. "<cr>")
end
local _5_
do
  local prefix_0_ = "Gitsigns"
  local cmd_0_ = "reset_hunk"
  _5_ = ("<cmd>" .. prefix_0_ .. " " .. cmd_0_ .. "<cr>")
end
local _6_
do
  local prefix_0_ = "Gitsigns"
  local cmd_0_ = "stage_hunk"
  _6_ = ("<cmd>" .. prefix_0_ .. " " .. cmd_0_ .. "<cr>")
end
wk.register({Q = {("<cmd>" .. "q!" .. "<cr>"), "quit!"}, W = {("<cmd>" .. "w!" .. "<cr>"), "save!"}, c = {n = {("<cmd>" .. "cnext" .. "<cr>"), "next"}, name = "quickfix", o = {("<cmd>" .. "copen" .. "<cr>"), "open"}, p = {("<cmd>" .. "cprev" .. "<cr>"), "previous"}, q = {("<cmd>" .. "cclose" .. "<cr>"), "close"}}, f = {e = {("<cmd>" .. "Explore" .. "<cr>"), "explore"}, f = {_0_, "file"}, n = {("<cmd>" .. "enew" .. "<cr>"), "new"}, name = "find", r = {_1_, "grep"}}, g = {b = {_2_, "blame"}, h = {n = {_3_, "next"}, name = "hunk", p = {_4_, "previous"}, r = {_5_, "reset"}, s = {_6_, "stage"}}, name = "git"}, l = {a = {("<cmd>lua vim.lsp." .. "buf.code_action" .. "()<cr>"), "actions"}, d = {n = {("<cmd>lua vim.lsp." .. "diagnostic.goto_next" .. "()<cr>"), "next"}, name = "diagnostics", p = {("<cmd>lua vim.lsp." .. "diagnostic.goto_prev" .. "()<cr>"), "previous"}}, f = {("<cmd>lua vim.lsp." .. "buf.formatting" .. "()<cr>"), "format"}, l = {("<cmd>lua vim.lsp." .. "diagnostic.show_line_diagnostics" .. "()<cr>"), "line"}, name = "lsp", r = {("<cmd>lua vim.lsp." .. "buf.rename" .. "()<cr>"), "rename"}}, p = {"\"*p<cr>", "paste"}, q = {("<cmd>" .. "q" .. "<cr>"), "quit"}, r = {":%s//g<left><left>", "replace"}, t = {n = {("<cmd>" .. "tabnext" .. "<cr>"), "next"}, name = "tabs", p = {("<cmd>" .. "tabprevious" .. "<cr>"), "previous"}, t = {("<cmd>" .. "tabnew" .. "<cr>"), "new"}}, w = {("<cmd>" .. "w" .. "<cr>"), "save"}, y = {"\"*y<cr>", "copy"}}, {mode = "n", prefix = "<leader>"})
wk.register({K = {("<cmd>lua vim.lsp." .. "buf.hover" .. "()<cr>"), "hover"}, ["<bs>"] = {"-", "back"}, g = {d = {("<cmd>lua vim.lsp." .. "buf.definition" .. "()<cr>"), "definition"}, name = __fnl_global__goto, r = {("<cmd>lua vim.lsp." .. "buf.reference" .. "()<cr>"), "reference"}}}, {mode = "n"})
wk.register({["<"] = {"<gv", "dedent"}, ["<leader>p"] = {"\"*p", "paste"}, ["<leader>so"] = {":sort <bar>w<bar>e<cr>", "sort"}, ["<leader>y"] = {"\"*y", "copy"}, [">"] = {">gv", "indent"}}, {mode = "v"})
wk.register({["<s-tab>"] = {"pumvisible() ? \"\\<c-p>\" : \"\\<s-tab>\"", "Previous Completion"}, ["<tab>"] = {"pumvisible() ? \"\\<c-n>\" : \"\\<tab>\"", "Next Completion"}}, {expr = true, mode = "i"})
wk.register({[",,"] = {("<cmd>" .. ":e ~/wiki/index.norg" .. "<cr>"), "neorg"}}, {mode = "n"})
local function _7_()
  return wk.register({N = {"?[A-z]*.norg<cr>", "previous"}, ["<bs>"] = {"<c-o>", "back"}, ["<cr>"] = {("<cmd>" .. "e <cfile>" .. "<cr>"), "follow"}, ["<s-tab>"] = {"?[A-z]*.norg<cr>", "previous"}, ["<tab>"] = {"/[A-z]*.norg<cr>", "next"}, n = {"/[A-z]*.norg<cr>", "next"}}, {buffer = vim.api.nvim_get_current_buf(), mode = "n"})
end
_G.wkneorg = _7_
wk.setup({ignore_missing = false, plugins = {spelling = {enabled = true, suggestions = 20}}})
local o = vim.o
o.autoindent = true
o.autoread = true
o.autowrite = true
o.backspace = "indent,eol,start"
o.backup = false
o.cmdheight = 1
o.compatible = false
o.completeopt = "menuone,noinsert,noselect"
o.concealcursor = ""
o.cursorline = true
o.diffopt = "filler,internal,algorithm:histogram,indent-heuristic"
o.encoding = "utf-8"
o.errorbells = false
o.expandtab = true
o.hidden = true
o.hlsearch = true
o.ignorecase = true
o.incsearch = true
o.laststatus = 2
o.lazyredraw = true
o.number = true
o.numberwidth = 1
o.omnifunc = "v:lua.vim.lsp.omnifunc"
o.ruler = true
o.shiftwidth = 2
o.showcmd = true
o.showmode = false
o.signcolumn = "yes"
o.smartcase = true
o.softtabstop = 2
o.splitbelow = true
o.splitright = true
o.swapfile = false
o.synmaxcol = 300
o.tabstop = 2
o.termguicolors = true
o.timeout = true
o.timeoutlen = 350
o.ttimeout = true
o.ttimeoutlen = 0
o.ttyfast = true
o.undofile = true
o.updatetime = 300
o.visualbell = true
o.wb = false
o.wildmenu = true
o.wildmode = "longest:full,full"
o.wrap = false
o.writebackup = false
local colorbuddy = require("colorbuddy")
colorbuddy.colorscheme("nordbuddy")
local lualine = require("lualine")
lualine.setup({options = {theme = "nord"}})
local function gitsigns()
  local gitsigns0 = require("gitsigns")
  return (gitsigns0).setup({keymaps = {}})
end
local function neorg()
  local neorg0 = require("neorg")
  return (neorg0).setup({load = {["core.defaults"] = {}, ["core.keybinds"] = {}, ["core.norg.concealer"] = {}, ["core.norg.dirman"] = {config = {autochdir = true, autodetect = true, workspaces = {wiki = "~/wiki"}}}}})
end
local function compe()
  local compe0 = require("compe")
  return (compe0).setup({autocomplete = true, debug = false, documentation = true, enabled = true, incomplete_delay = 400, max_abbr_width = 100, max_kind_width = 100, max_menu_width = 100, preselect = "disable", resolve_timeout = 800, source = {buffer = true, nvim_lsp = true, path = true}, source_timeout = 200, throttle_time = 80})
end
local function treesitter()
  local treesitter0 = require("nvim-treesitter.configs")
  return (treesitter0).setup({ensure_installed = {"bash", "clojure", "commonlisp", "dockerfile", "fennel", "go", "gomod", "graphql", "hcl", "html", "javascript", "latex", "lua", "nix", "ruby", "rust", "yaml", "zig"}, highlight = {enable = true}, indent = {enable = true}})
end
vim.defer_fn(compe, 50)
vim.defer_fn(gitsigns, 50)
vim.defer_fn(neorg, 50)
vim.defer_fn(treesitter, 50)
local g = vim.g
g.mapleader = " "
g.diagnostic_auto_popup_while_jump = 0
g.diagnostic_enable_underline = 1
g.diagnostic_enable_virtual_text = 1
g.diagnostic_insert_delay = 0
g.netrw_banner = 0
g.localcoptydircmd = "cp -r"
g.rmdir_cmd = "rm -r"
g.completion_chain_complete_list = {default = {comment = {}, default = {{complete_items = {"lsp", "snippet"}}, {mode = "<c-p>"}, {mode = "<c-n>"}}, string = {{complete_items = {"path"}}}}}
return nil
