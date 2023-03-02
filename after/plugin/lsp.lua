local lsp = require('lsp-zero').preset({
    name = 'recommended',
    set_lsp_keymaps = true,
    manage_nvim_cmp = true,
    suggest_lsp_servers = true,
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr }
    local bind = vim.keymap.set

    bind('n', '<leader>f', '<cmd>lua vim.lsp.buf.format()<cr>', opts)
    -- more keybindings...
end)

lsp.setup()
