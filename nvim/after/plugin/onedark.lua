return {
    -- start colorscheme when loading Neovim.
    {
        "navarasu/onedark.nvim",
        lazy = false, -- ensure that this is loaded at startup.
        priority = 1000,
        config = function()
            -- actually load the colorscheme.
            vim.cmd([[colorscheme onedark]])
        end,
    }

}
