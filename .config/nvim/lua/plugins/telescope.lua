    local nnoremap = require("utils").nnoremap
    nnoremap("<leader>fw", "<CMD>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>")
    nnoremap("<leader>ff", "<CMD>Telescope find_files<CR>")
    nnoremap("<leader>fg", "<CMD>Telescope live_grep<CR>")
    nnoremap("<leader>fb", "<CMD>Telescope buffers<CR>")
    nnoremap("<leader>fh", "<CMD>Telescope help_tags<CR>")
