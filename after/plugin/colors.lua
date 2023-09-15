function ColorMyNVIM(color)
    -- color = color or "rose-pine"
    color = color or "tokyonight-night"
    vim.cmd.colorscheme(color)
end

ColorMyNVIM()
