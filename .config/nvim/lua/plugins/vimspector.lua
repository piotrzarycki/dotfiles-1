local utils = require("utils")
local nmap = utils.nmap
local xmap = utils.xmap
vim.g["vimspector_enable_mappings"] = 'HUMAN'
nmap("<leader>vi", "<Plug>VimspectorBalloonEval")
xmap("<leader>vi", "<Plug>VimspectorBalloonEval")
