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
            a = { fg = "#16151f", bg = "#abb2bf", gui = "bold" }, 
            b = { fg = "#abb2bf", bg = "#16151f" },
            c = { fg = "#abb2bf", bg = "#16151f" },
          },
          insert = {
            a = { fg = "#16151f", bg = "#98c379", gui = "bold" },
            b = { fg = "#98c379", bg = "#16151f" },
            c = { fg = "#abb2bf", bg = "#16151f" },
          },
          visual = {
            a = { fg = "#16151f", bg = "#ce95b8", gui = "bold" }, 
            b = { fg = "#ce95b8", bg = "#16151f" },
            c = { fg = "#abb2bf", bg = "#16151f" },
          },
          replace = {
            a = { fg = "#16151f", bg = "#ff4e4e", gui = "bold" },
            b = { fg = "#ff4e4e", bg = "#16151f" },
            c = { fg = "#abb2bf", bg = "#16151f" },
          },
          command = {
            a = { fg = "#16151f", bg = "#fb7385", gui = "bold" },
            b = { fg = "#fb7385", bg = "#16151f" },
            c = { fg = "#abb2bf", bg = "#16151f" },
          },
          inactive = {
            a = { fg = "#5c6370", bg = "#16151f" }, 
            b = { fg = "#5c6370", bg = "#16151f" },
            c = { fg = "#5c6370", bg = "#16151f" },
          },
        },
        component_separators = "|",
        section_separators = { left = "", right = "" },
      },
    },
  },
}
