return {
    -- "gc" to comment visual regions/lines
    {'numToStr/Comment.nvim',
        opts = {}
    },
    -- Highlight todo, notes, etc in comments
    { 'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            signs = false,
            highlight = {
                keyword = "bg",
                pattern = [[.*<(KEYWORDS)\s*]]
            }
        }
    },
}
