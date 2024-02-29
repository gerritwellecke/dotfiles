return {
    'Raimondi/delimitMate',
    config = function()
        vim.g.delimitMate_expand_cr = 1
        -- expand space in bash as it is needed by bash-syntax
        vim.cmd("au FileType cpp,sh let b:delimitMate_expand_space=1")
        -- add $ to autoclose symbols to type inline math in LaTeX
        vim.cmd([[au FileType tex let b:delimitMate_quotes="\" ` $"]])
    end,
}
