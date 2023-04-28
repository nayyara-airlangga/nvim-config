local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- My plugins here
local plugins = {
	"wbthomason/packer.nvim",
	"nvim-lua/popup.nvim",
	"nvim-lua/plenary.nvim",
	"windwp/nvim-autopairs",
	"folke/trouble.nvim",
	"goolord/alpha-nvim",
	"lukas-reineke/indent-blankline.nvim",

	-- Nvimtree
	"kyazdani42/nvim-web-devicons",
	"kyazdani42/nvim-tree.lua",

	-- Toggleterm
	"akinsho/toggleterm.nvim",

	-- Tabline
	{
		"romgrk/barbar.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	},

	-- Lualine
	"nvim-lualine/lualine.nvim",

	-- Comments
	"numToStr/Comment.nvim",
	"JoosepAlviste/nvim-ts-context-commentstring",

	-- Colorschemes
	"rafi/awesome-vim-colorschemes",
	"dracula/vim",

	-- Completions
	"hrsh7th/nvim-cmp", -- The completion plugin
	"hrsh7th/cmp-buffer", -- buffer completions
	"hrsh7th/cmp-path", -- path completions
	"hrsh7th/cmp-cmdline", -- cmdline completions
	"saadparwaiz1/cmp_luasnip", -- snippet completions
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",

	-- Snippets
	"L3MON4D3/LuaSnip", --snippet engine
	"rafamadriz/friendly-snippets", -- a bunch of snippets to use

	-- LSP
	"neovim/nvim-lspconfig",
	"tamago324/nlsp-settings.nvim", -- language server settings defined in json for
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"jose-elias-alvarez/null-ls.nvim",
	"mfussenegger/nvim-jdtls",
	{ "https://gitlab.com/schrieveslaach/sonarlint.nvim", as = "sonarlint.nvim" },
	{ "akinsho/flutter-tools.nvim", requires = "nvim-lua/plenary.nvim" },

	-- Debugger
	"mfussenegger/nvim-dap",

	-- Telescope
	"nvim-telescope/telescope.nvim",
	"nvim-telescope/telescope-media-files.nvim",

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	},
	"p00f/nvim-ts-rainbow",
	"nvim-treesitter/playground",

	-- Git
	"lewis6991/gitsigns.nvim",

	-- Markdown
	{
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
}

-- Install your plugins here
return packer.startup(function(use)
	for k, v in pairs(plugins) do
		use(v)
	end

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
