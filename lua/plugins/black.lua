return {
  "psf/black",
  config = function()
    local group = vim.api.nvim_create_augroup("black_on_save", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.py",
      command = "Black",
    })
  end,
}
