function ColorMyNVIM(color)
    -- color = color or "rose-pine"
    color = color or "dark_flat"
    vim.cmd.colorscheme(color)
end

ColorMyNVIM()
