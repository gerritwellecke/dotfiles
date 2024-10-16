return {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
        -- See `:help gitsigns.txt`
        signs = {
            -- add = { text = '|' },
            -- change = { text = '|' },
            add = { text = '+' },
            change = { text = '~' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
        },
        sign_priority = 20,
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            vim.keymap.set('n', ']c', function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, {expr=true, desc = 'next hunk'})

            vim.keymap.set('n', '[c', function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, {expr=true, desc  = 'previous hunk'})

            -- Actions
            vim.keymap.set('n', '<leader>hs', gs.stage_hunk, {desc = 'stage hunk'})
            vim.keymap.set('n', '<leader>hr', gs.reset_hunk, {desc = 'reset hunk'})
            vim.keymap.set('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc = 'stage hunk'})
            vim.keymap.set('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc = 'reset hunk'})
            vim.keymap.set('n', '<leader>hS', gs.stage_buffer, {desc = 'stage buffer'})
            vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, {desc = 'unstage hunk'})
            vim.keymap.set('n', '<leader>hR', gs.reset_buffer, {desc = 'reset buffer'})
            vim.keymap.set('n', '<leader>hp', gs.preview_hunk, {desc = 'preview hunk'})
            vim.keymap.set('n', '<leader>hb', function() gs.blame_line{full=true} end, {desc = 'blame this line'})
            vim.keymap.set('n', '<leader>tb', gs.toggle_current_line_blame, {desc = 'toggle line blame'})
            vim.keymap.set('n', '<leader>hd', gs.diffthis, {desc = 'diff current changes'})
            vim.keymap.set('n', '<leader>hD', function() gs.diffthis('HEAD~') end, {desc = 'diff with HEAD'})
            vim.keymap.set('n', '<leader>td', gs.toggle_deleted, {desc = 'toggle deleted lines'})

            -- Text object
            vim.keymap.set({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', {desc = 'inner hunk'})
        end
    },
}
