return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("pax.telescope")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        icons_enabled = true,
        theme = {
          normal = {
            a = { fg = "#1e1e2e", bg = "#cdd6f4", gui = "bold" }, 
            b = { fg = "#cdd6f4", bg = "#none" },
            c = { fg = "#cdd6f4", bg = "#none" },
          },
          insert = {
            a = { fg = "#1e1e2e", bg = "#a6e3a1", gui = "bold" },
            b = { fg = "#a6e3a1", bg = "#none" },
            c = { fg = "#cdd6f4", bg = "#none" },
          },
          visual = {
            a = { fg = "#1e1e2e", bg = "#f5c2e7", gui = "bold" }, 
            b = { fg = "#f5c2e7", bg = "#none" },
            c = { fg = "#cdd6f4", bg = "#none" },
          },
          replace = {
            a = { fg = "#1e1e2e", bg = "#f38ba8", gui = "bold" },
            b = { fg = "#f38ba8", bg = "#none" },
            c = { fg = "#cdd6f4", bg = "#none" },
          },
          command = {
            a = { fg = "#1e1e2e", bg = "#f9e2af", gui = "bold" },
            b = { fg = "#f9e2af", bg = "#none" },
            c = { fg = "#cdd6f4", bg = "#none" },
          },
          inactive = {
            a = { fg = "#585b70", bg = "none" }, 
            b = { fg = "#585b70", bg = "none" },
            c = { fg = "#585b70", bg = "none" },
          },
        },
        component_separators = "|",
        section_separators = { left = "", right = "" },
      },
    },
  },
}
