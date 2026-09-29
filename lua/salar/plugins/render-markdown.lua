return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = "markdown",
	cmd = { "RenderMarkdown" },
	keys = {
		{ "<leader>om", "<cmd>RenderMarkdown toggle<CR>", desc = "Toggle markdown render" },
	},
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		-- Neovim 0.12 has no bundled markdown highlighting of its own, so the
		-- plugin stays enabled there; treesitter is required either way.
		enabled = pcall(vim.treesitter.language.add, "markdown"),
		file_types = { "markdown" },
		preset = "obsidian",
		render_modes = { "n", "c", "t" },
		restart_highlighter = false,
		-- Default is `true`; keep it off so anti-conceal does not fight the
		-- obsidian preset's own conceals.
		anti_conceal = {
			enabled = false,
		},
	},
}
