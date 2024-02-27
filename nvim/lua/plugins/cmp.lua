return {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
        -- TODO change to UltiSnips!
        -- Snippet Engine & its associated nvim-cmp source
        -- 'L3MON4D3/LuaSnip',
        -- 'saadparwaiz1/cmp_luasnip',
        'SirVer/ultisnips',
        'quangnguyen30192/cmp-nvim-ultisnips',

        -- Adds LSP completion capabilities
        'hrsh7th/cmp-nvim-lsp',

        -- Signature helps, i.e. floating window during function arguments
        'hrsh7th/cmp-nvim-lsp-signature-help',
        --"ray-x/lsp_signature.nvim",

        -- Adds a number of user-friendly snippets
        --'rafamadriz/friendly-snippets',

        -- recommended config:
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
    },
}
