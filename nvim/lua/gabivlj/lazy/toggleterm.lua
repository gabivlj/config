return {
    "akinsho/toggleterm.nvim",

    config = function ()
        toggleterm = require('toggleterm')

        require('telescope').setup({})

        local builtin = require('telescope.builtin')
    end
}
