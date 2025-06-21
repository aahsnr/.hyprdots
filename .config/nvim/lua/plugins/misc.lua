return {
  "gpanders/nvim-parinfer",
  "HiPhish/rainbow-delimiters.nvim",
  "rareitems/hl_match_area.nvim",
  {
    "andymass/vim-matchup",
    setup = function() vim.g.matchup_matchparen_offscreen = { method = "popup" } end,
  },
}
