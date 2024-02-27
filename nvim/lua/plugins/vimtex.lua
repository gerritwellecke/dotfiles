return {
    'lervag/vimtex',
    config = function()
        vim.g.tex_flavor='latex'
        vim.g.vimtex_view_method='skim'
        vim.g.vimtex_quickfix_mode=0

        vim.api.nvim_create_autocmd( "FileType", { pattern = 'tex', callback = function() vim.o.conceallevel = 1 end })
        vim.api.nvim_create_autocmd(
            "FileType",
            {
                pattern = 'tex',
                callback = function()
                    local opts = { accents = 1, ligatures = 1, cites = 1, fancy = 0, greek = 1, math_bounds = 0, math_delimiters = 1, math_fracs = 0, math_super_sub = 0, math_symbols = 1, sections = 0, styles = 1, spacing = 0, }
                    vim.g.vimtex_syntax_conceal = opts
                end,
            }
        )
    end
}
