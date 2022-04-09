local utils = require("utils")
local nmap = utils.nmap
vim.g["test#javascript#mocha#file_pattern"] = '.*' 
nmap("t<C-n>", ":TestNearest<CR>", { noremap = true, silent = true})
nmap("t<C-f>", ":TestFile<CR>", { noremap = true, silent = true})
nmap("t<C-s>", ":TestSuite<CR>", { noremap = true, silent = true})
nmap("t<C-l>", ":TestLast<CR>", { noremap = true, silent = true})
nmap("t<C-g>", ":TestVisit<CR>", { noremap = true, silent = true})
