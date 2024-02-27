return {
    'jpalardy/vim-slime',
    config = function()
        vim.g.slime_target = 'tmux'
        vim.g.slime_paste_file = vim.fn.tempname()
        vim.g.slime_bracketed_paste = 1
    end,
}
