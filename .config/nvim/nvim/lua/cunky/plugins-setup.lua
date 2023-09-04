local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- reload neovim whenever this file is saved
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
    augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)
	-- My plugins here
	use("wbthomason/packer.nvim") -- packer (nvim package manager)
	use({ "sekke276/dark_flat.nvim" })
	use("nvim-lua/plenary.nvim") -- lua functions for other plugins
	use("christoomey/vim-tmux-navigator") -- ctrl hjkl navigation between splits / tmux
	use("szw/vim-maximizer") -- leader sm to focus / maximize a split temporarily
	use("tpope/vim-surround") -- surround with brackets or something (ys motion character)
	use("numToStr/Comment.nvim") -- make commenting easier (gcc)
	use("nvim-tree/nvim-tree.lua") -- file explorer
	use("nvim-lualine/lualine.nvim") -- status line
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- telescope dependency
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- telescope (fuzzy finder)
	use("hrsh7th/nvim-cmp") -- autocompletion
	use("hrsh7th/cmp-buffer") -- source for text in current buffer
	use("hrsh7th/cmp-path") -- source for file paths
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- let nvimcmp to show snippets
	use("rafamadriz/friendly-snippets") -- source for snippets multi lang
	-- lsp: language server protocol => really smart autocomplete, code actions, renaming etc
	use("williamboman/mason.nvim") -- managing and installing lsp servers, linters, formatters
	use("williamboman/mason-lspconfig.nvim") -- bridge the gap between surrounding packs
	use("neovim/nvim-lspconfig") -- configuring lsp servers
	use("hrsh7th/cmp-nvim-lsp") -- configure lsp servers to appear in autocomplete
	use({ "glepnir/lspsaga.nvim", branch = "main" }) -- enhanced UI for lsp
	use("jose-elias-alvarez/typescript.nvim") -- more functionality for typescript server (imports and file renames)
	use("onsails/lspkind.nvim") -- icons to lsp window
	use("jose-elias-alvarez/null-ls.nvim") -- formatting and linting
	use("jayp0521/mason-null-ls.nvim")
	-- syntax highlighting, autoclose brackets
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("vim-treesitter.install").update({ with_sync = true })
		end,
	})
	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")
	use("lewis6991/gitsigns.nvim")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
