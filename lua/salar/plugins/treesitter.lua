local parsers = {
	"json",
	"javascript",
	"typescript",
	"tsx",
	"yaml",
	"html",
	"css",
	"prisma",
	"markdown",
	"markdown_inline",
	"svelte",
	"graphql",
	"bash",
	"lua",
	"vim",
	"dockerfile",
	"gitignore",
	"query",
	"vimdoc",
	"c",
	"cpp",
	"haskell",
	"gdscript",
	"gdshader",
	"godot_resource",
}

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	-- The `main` branch is a full rewrite that does not support lazy loading.
	lazy = false,
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local treesitter = require("nvim-treesitter")

		-- nvim-treesitter only accepts `install_dir`; highlighting, folding and
		-- friends are now driven by Neovim core, so the old `configs` table with
		-- `highlight.enable`/`ensure_installed`/... no longer exists.
		treesitter.setup({
			install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site"),
		})

		-- nvim-treesitter ships a Haskell parser, but not separate parsers for
		-- literate Haskell or Cabal files.
		vim.treesitter.language.register("haskell", "lhaskell")

		-- Neovim core's own markdown injection query handles fenced code blocks
		-- and HTML, and it passes a `table<integer, TSNode[]>` per capture, which
		-- is what the core `set-lang-from-info-string!` directive expects. No
		-- override is needed here: registering one against a captured node list
		-- used to break LSP hover rendering (hover docs are markdown filetype).
		-- `query_predicates` ships as a plugin/ file and is sourced automatically.

		-- Install missing parsers. `:wait` makes this synchronous so parsers are
		-- available before the first buffer is highlighted. It is a no-op when
		-- everything is already installed.
		local installed = {}
		for _, parser in ipairs(treesitter.get_installed("parsers")) do
			installed[parser] = true
		end

		local missing = {}
		for _, parser in ipairs(parsers) do
			if not installed[parser] then
				missing[#missing + 1] = parser
			end
		end

		if #missing > 0 then
			treesitter.install(missing):wait(300000)
		end

		-- Highlighting: core API, one autocmd per filetype.
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("salar-treesitter-highlight", { clear = true }),
			callback = function(args)
				local lang = vim.treesitter.language.get_lang(args.match)

				if not lang then
					return
				end

				local ok, parser = pcall(vim.treesitter.get_parser, args.buf, lang)
				if not ok or not parser then
					return
				end

				-- Treesitter indent can override normal `o`/`O` newline indent.
				vim.treesitter.start(args.buf, lang)
			end,
		})

		require("nvim-ts-autotag").setup({})
	end,
}
