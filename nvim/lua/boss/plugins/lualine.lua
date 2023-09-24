  return    {
        {
            "nvim-lualine/lualine.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons" },
            lazy = false,
            priority = 9000,
            config = function()
            local lualine = require("lualine")
            lualine.setup({
              options = {
                theme = "codedark",
              },
            })
            end,
        },


    }

