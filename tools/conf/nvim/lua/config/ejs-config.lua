-- Alternative EJS configuration
-- Use this if embedded_template doesn't work well

-- Set up EJS as a custom filetype with JavaScript-like behavior
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.ejs",
  callback = function()
    -- Set filetype to javascript for better LSP support
    vim.bo.filetype = "javascript"
    -- But use HTML syntax highlighting as base
    vim.cmd("set syntax=html")
    -- Enable JavaScript omnicompletion
    vim.bo.omnifunc = "javascriptcomplete#CompleteJS"
  end,
})

-- You can enable this alternative by requiring it in init.lua:
-- require('config.ejs-config')