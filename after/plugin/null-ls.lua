-- lua/rootiens/null-ls.lua
local null_ls = require("null-ls")

local function get_prettier_config()
  local cwd = vim.fn.getcwd()
  local config_files = { ".prettierrc", ".prettierrc.json", ".prettierrc.js", "prettier.config.js" }
  for _, file in ipairs(config_files) do
    if vim.fn.filereadable(cwd .. "/" .. file) == 1 then
      return cwd .. "/" .. file
    end
  end
  return nil
end

-- Create or get the augroup for formatting
local formatting_group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier.with({
      extra_args = function(_)
        local config = get_prettier_config()
        if config then
          return { "--config", config }
        end
        return {}
      end,
    }),
    -- Add other sources if needed
  },
  on_attach = function(client, bufnr)
    -- Use the new API for checking formatting capability
    if client.server_capabilities.documentFormattingProvider then
      -- Clear any existing autocmds for this buffer
      vim.api.nvim_clear_autocmds({ group = formatting_group, buffer = bufnr })
      -- Create an autocommand that formats before saving
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = formatting_group,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})

