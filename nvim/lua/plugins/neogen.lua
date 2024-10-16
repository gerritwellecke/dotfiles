return {
    "danymat/neogen",
    config = function()
        -- run default setup
        require('neogen').setup({})

        -- keymappings
        local opts = { noremap = true, silent = true , desc="neogen annotate"}
        vim.api.nvim_set_keymap("n", "<Leader>d", ":lua require('neogen').generate()<CR>", opts)
    end
}
