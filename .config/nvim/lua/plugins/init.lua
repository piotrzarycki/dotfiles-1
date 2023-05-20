local g = vim.g
local fn = vim.fn
local utils = require("utils")
local nmap = utils.nmap

local plugLoad = fn["functions#PlugLoad"]
local plugBegin = fn["plug#begin"]
local plugEnd = fn["plug#end"]
local Plug = fn["plug#"]

plugLoad()
-- cmd("call functions#PlugLoad()")
plugBegin("~/.config/nvim/plugged")

-- NOTE: the argument passed to Plug has to be wrapped with single-quotes

-- a set of lua helpers that are used by other plugins
Plug "nvim-lua/plenary.nvim"

-- easy commenting
Plug "tpope/vim-commentary"
Plug "JoosepAlviste/nvim-ts-context-commentstring"

-- bracket mappings for moving between buffers, quickfix items, etc.
Plug "tpope/vim-unimpaired"

-- mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.
Plug "tpope/vim-surround"

-- endings for html, xml, etc. - ehances surround
Plug "tpope/vim-ragtag"

-- substitution and abbreviation helpers
Plug "tpope/vim-abolish"

-- enables repeating other supported plugins with the . command
Plug "tpope/vim-repeat"

-- single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
Plug "AndrewRadev/splitjoin.vim"

-- detect indent style (tabs vs. spaces)
Plug "tpope/vim-sleuth"

-- setup editorconfig
Plug "editorconfig/editorconfig-vim"

-- fugitive
Plug "tpope/vim-fugitive"
Plug "tpope/vim-rhubarb"
nmap("<leader>gr", ":Gread<cr>")
nmap("<leader>gb", ":G blame<cr>")

-- general plugins
-- emmet support for vim - easily create markdup wth CSS-like syntax
Plug "mattn/emmet-vim"

-- match tags in html, similar to paren support
Plug("gregsexton/MatchTag", {["for"] = "html"})

-- html5 support
Plug("othree/html5.vim", {["for"] = "html"})

-- mustache support
Plug "mustache/vim-mustache-handlebars"

-- pug / jade support
Plug("digitaltoad/vim-pug", {["for"] = {"jade", "pug"}})

-- nunjucks support
-- Plug "niftylettuce/vim-jinja"

-- edit quickfix list
Plug "itchyny/vim-qfedit"

-- liquid support
Plug "tpope/vim-liquid"

Plug("othree/yajs.vim", {["for"] = {"javascript", "javascript.jsx", "html"}})
-- Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx', 'html'] }
Plug("moll/vim-node", {["for"] = "javascript"})
Plug "MaxMEllon/vim-jsx-pretty"
g.vim_jsx_pretty_highlight_close_tag = 1
Plug("leafgarland/typescript-vim", {["for"] = {"typescript", "typescript.tsx"}})

Plug("wavded/vim-stylus", {["for"] = {"stylus", "markdown"}})
Plug("groenewege/vim-less", {["for"] = "less"})
Plug("hail2u/vim-css3-syntax", {["for"] = "css"})
Plug("cakebaker/scss-syntax.vim", {["for"] = "scss"})
Plug("stephenway/postcss.vim", {["for"] = "css"})
Plug "udalov/kotlin-vim"

-- Open markdown files in Marked.app - mapped to <leader>m
Plug("itspriddle/vim-marked", {["for"] = "markdown", on = "MarkedOpen"})
nmap("<leader>m", ":MarkedOpen!<cr>")
nmap("<leader>mq", ":MarkedQuit<cr>")
nmap("<leader>*", "*<c-o>:%s///gn<cr>")

Plug("elzr/vim-json", {["for"] = "json"})
g.vim_json_syntax_conceal = 0

Plug "ekalinin/Dockerfile.vim"
Plug "jparise/vim-graphql"

Plug "hrsh7th/cmp-vsnip"
Plug "hrsh7th/vim-vsnip"
Plug "hrsh7th/vim-vsnip-integ"
local snippet_dir = "~/.config/nvim/snippets"
g.vsnip_snippet_dir = snippet_dir
g.vsnip_filetypes = {
  javascriptreact = {"javascript"},
  typescriptreact = {"typescript"},
  ["typescript.tsx"] = {"typescript"}
}

-- add color highlighting to hex values
Plug "norcalli/nvim-colorizer.lua"

-- use devicons for filetypes
Plug "kyazdani42/nvim-web-devicons"

-- fast lau file drawer
Plug "kyazdani42/nvim-tree.lua"

-- Show git information in the gutter
Plug "lewis6991/gitsigns.nvim"

-- Helpers to configure the built-in Neovim LSP client
Plug "neovim/nvim-lspconfig"
-- neovim completion
Plug "hrsh7th/cmp-nvim-lsp"
Plug "hrsh7th/cmp-nvim-lua"
Plug "hrsh7th/cmp-buffer"
Plug "hrsh7th/cmp-path"
Plug "hrsh7th/nvim-cmp"

-- treesitter enables an AST-like understanding of files
Plug("nvim-treesitter/nvim-treesitter", {["do"] = ":TSUpdate"})
-- show treesitter nodes
Plug "nvim-treesitter/playground"
-- enable more advanced treesitter-aware text objects
Plug "nvim-treesitter/nvim-treesitter-textobjects"
-- add rainbow highlighting to parens and brackets
Plug "p00f/nvim-ts-rainbow"

-- show nerd font icons for LSP types in completion menu
Plug "onsails/lspkind-nvim"

-- base16 syntax themes that are neovim/treesitter-aware
Plug "RRethy/nvim-base16"

-- status line plugin
Plug "feline-nvim/feline.nvim"

-- automatically complete brackets/parens/quotes
Plug "windwp/nvim-autopairs"

-- Style the tabline without taking over how tabs and buffers work in Neovim
Plug "alvarosevilla95/luatab.nvim"

-- improve the default neovim interfaces, such as refactoring
Plug "stevearc/dressing.nvim"

-- Navigate a code base with a really slick UI
Plug "nvim-telescope/telescope.nvim"
Plug "nvim-telescope/telescope-rg.nvim"

-- Startup screen for Neovim
Plug "startup-nvim/startup.nvim"

-- fzf
Plug "$HOMEBREW_PREFIX/opt/fzf"
Plug "junegunn/fzf.vim"
-- Power telescope with FZF
Plug("nvim-telescope/telescope-fzf-native.nvim", {["do"] = "make"})

Plug "folke/trouble.nvim"
Plug "nvim-lua/popup.nvim"
Plug "nvim-lua/plenary.nvim"

Plug "nvim-telescope/telescope.nvim"
Plug "puremourning/vimspector"

-- vim test
Plug "janko/vim-test"
-- test coverage
Plug "andythigpen/nvim-coverage"
-- go lang
Plug "ray-x/go.nvim"
Plug "ray-x/guihua.lua"
Plug "saadparwaiz1/cmp_luasnip"
Plug "L3MON4D3/LuaSnip"
Plug "folke/which-key.nvim"
Plug ('catppuccin/nvim', { ["as"] = "catppuccin" })
  -- Debugging
Plug "mfussenegger/nvim-dap"
Plug "mxsdev/nvim-dap-vscode-js"
-- Debugger user interface
Plug "rcarriga/nvim-dap-ui"
Plug "mfussenegger/nvim-jdtls"
-- java
Plug "williamboman/mason.nvim"
Plug "williamboman/mason-lspconfig.nvim"
--terminal
Plug('akinsho/toggleterm.nvim', { ["tag"] = "*" })
Plug('jose-elias-alvarez/null-ls.nvim')
Plug('ldelossa/nvim-dap-projects')
Plug "github/copilot.vim"
Plug 'MunifTanjim/prettier.nvim'
plugEnd()


require("nvim-autopairs").setup()
require("mason").setup()
require("mason-lspconfig").setup()
require("colorizer").setup()
require("plugins.catppuccin")
require("plugins.gitsigns")
require("plugins.trouble")
--require("plugins.java")
require("plugins.fzf")
require("plugins.prettier")
require("plugins.null-ls")
require("plugins.lspconfig")
require("plugins.startify")
require("plugins.nvimtree")
require("plugins.tabline")
require("plugins.feline")
require("plugins.startup")
require("plugins.treesitter")
require("plugins.telescope")
require("plugins.completion")
require("plugins.vimtest")
require("plugins.vimspector")
require("plugins.luasnip")
require("plugins.which-key")
require("plugins.nvim-coverage")
require("plugins.go")
require("plugins.toggleterm")
require("plugins.dap")
require('nvim-dap-projects').search_project_config()
require('plugins.dap.dap-vscode-js')
vim.cmd.colorscheme "catppuccin"
