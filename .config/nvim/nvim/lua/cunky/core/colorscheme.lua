vim.cmd.colorscheme("dark_flat")

require("dark_flat").setup({
	transparent = true,
	colors = {
		bg = "#18191a",
	},
	themes = function(colors)
		return {
			Normal = { bg = colors.bg },
		}
	end,
	italics = true,
})
