return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = "Telescope",
    build = 'cmake -S -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install',
    keys = {
      { '<leader>f', '<cmd>Telescope find_files<cr>', mode = { "n" }, desc = "Telescope find_files" },
      { '<leader>b', '<cmd>Telescope buffers<cr>', mode = { "n" }, desc = "Telescope buffers" },
      { '<leader>g', '<cmd>Telescope grep_string<cr>', mode = { "n" }, desc = "Telescope grep_string" },
      { '<leader>r', '<cmd>Telescope live_grep<cr>', mode = { "n" }, desc = "Telescope live_grep" },
      { '<leader>;', '<cmd>Telescope<cr>', mode = { "n" }, desc = "Telescope options" },
    },
    config = {},
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    dependencies = {'nvim-telescope/telescope.nvim'},
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
    config = function()
      require('telescope').load_extension('fzf')
    end,
  },
  {
    'junegunn/fzf.vim',
    event = "VeryLazy",
  }
}
