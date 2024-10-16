return {
    'nvim-tree/nvim-tree.lua',
    version = "*",
    lazy = false,
    config = function()
        require("nvim-tree").setup {}

        -- [[ Mappings for NvimTree ]]
        vim.keymap.set('n', '<leader>s', '<cmd>NvimTreeFocus<CR>')
    end,
}
