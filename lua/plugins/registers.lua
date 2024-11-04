return {
  {
    'tversteeg/registers.nvim',
    config = function()
      require('registers').setup({
        window = {
          border = "rounded", 
          transparency = 10, 
          max_width = 200,
        },
        hide_empty = true, 
      })
    end,
  }
}