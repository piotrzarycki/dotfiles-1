    local nnoremap = require("utils").nnoremap
    local colors = require("catppuccin.palettes").get_palette()
    local TelescopeColor = {
        TelescopeMatching = { fg = colors.flamingo },
        TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },

        TelescopePromptPrefix = { bg = colors.surface0 },
        TelescopePromptNormal = { bg = colors.surface0 },
        TelescopeResultsNormal = { bg = colors.mantle },
        TelescopePreviewNormal = { bg = colors.mantle },
        TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
        TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
        TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
        TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
        TelescopeResultsTitle = { fg = colors.mantle },
        TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
    }

for hl, col in pairs(TelescopeColor) do
	vim.api.nvim_set_hl(0, hl, col)
end
    nnoremap("<leader>fw", "<CMD>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>")
    nnoremap("<leader>ff", "<CMD>Telescope find_files<CR>")
    nnoremap("<leader>fg", "<CMD>Telescope live_grep<CR>")
    nnoremap("<leader>fb", "<CMD>Telescope buffers<CR>")
    nnoremap("<leader>fh", "<CMD>Telescope help_tags<CR>")
    nnoremap("<leader>fc", "<CMD>Telescope commands<CR>")
