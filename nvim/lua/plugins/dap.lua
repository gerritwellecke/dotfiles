return {
    {'mfussenegger/nvim-dap',
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
            'rcarriga/nvim-dap-ui',
            'jay-babu/mason-nvim-dap.nvim',
            'mfussenegger/nvim-dap-python',
        },
        config = function()
            local dap = require "dap"
            local ui = require "dapui"

            require("mason-nvim-dap").setup()
            require("dapui").setup()

            -- python 
            require("dap-python").setup()

            -- C++
            dap.adapters.lldb = {
                type = 'executable',
                command = '/opt/homebrew/opt/llvm/bin/lldb-dap', -- adjust as needed, must be absolute path
                name = 'lldb'
            }
            dap.configurations.cpp = {
                {
                    name = 'Launch',
                    type = 'lldb',
                    request = 'launch',
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                    args = {},
                },
            }

            -- dap UI config
            dap.listeners.before.attach.dapui_config = function()
                ui.open({reset=true})
            end
            dap.listeners.before.launch.dapui_config = function()
                ui.open({reset=true})
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                ui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                ui.close()
            end

            -- key mappings for debugging
            vim.keymap.set('n', '<leader>bc', function() dap.continue() end, {desc = 'DEBUG [c]ontinue'})
            vim.keymap.set('n', '<leader>bn', function() dap.step_over() end, {desc = 'DEBUG step over ([n]ext)'})
            vim.keymap.set('n', '<leader>bp', function() dap.step_back() end, {desc = 'DEBUG step back ([p]revious)'})
            vim.keymap.set('n', '<leader>bi', function() dap.step_into() end, {desc = 'DEBUG step [i]nto'})
            vim.keymap.set('n', '<leader>bo', function() dap.step_out() end, {desc = 'DEBUG step [o]ut'})
            vim.keymap.set('n', '<Leader>bb', function() dap.toggle_breakpoint() end, {desc = 'DEBUG toggle [b]reakpoint'})
            vim.keymap.set('n', '<Leader>be', function() ui.eval() end, {desc = 'DEBUG [e]valuate under cursor'})
            vim.keymap.set('n', '<Leader>be', function() dap.run_to_cursor() end, {desc = 'DEBUG [r]un to cursor'})
            -- vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
            vim.keymap.set('n', '<Leader>bl', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
            -- vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
            -- vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
            vim.keymap.set({'n', 'v'}, '<Leader>bh', function()
                require('dap.ui.widgets').hover()
            end, {desc = 'DEBUG widget: [h]over'})
            -- vim.keymap.set({'n', 'v'}, '<Leader>bd', function()
            --     require('dap.ui.widgets').preview()
            -- end, {desc = 'DEBUG widget: preview'})
            -- vim.keymap.set('n', '<Leader>bf', function()
            --     local widgets = require('dap.ui.widgets')
            --     widgets.centered_float(widgets.frames)
            -- end, {desc = 'DEBUG widget: [f]rames'})
            vim.keymap.set('n', '<Leader>bs', function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.scopes)
            end, {desc = 'DEBUG widget: [s]copes'})
        end
    },
}
