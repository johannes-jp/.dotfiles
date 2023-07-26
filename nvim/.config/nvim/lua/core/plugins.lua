--bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


local plugins = {
	"theprimeagen/harpoon",
	"mbbill/undotree",
	"tpope/vim-fugitive",
	"norcalli/nvim-base16.lua",
	"nvim-lua/plenary.nvim",
	{	'nvim-telescope/telescope.nvim', tag = '0.1.2',
        -- or                              , branch = '0.1.x',
	},
	{	"nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{   "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        config = function() require("chatgpt").setup() end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }},

	{   "VonHeikemen/lsp-zero.nvim",
		branch = 'v2.x',
		dependencies = {
			-- LSP Support
			{'neovim/nvim-lspconfig'}, -- Required
			{'williamboman/mason.nvim', build = function() pcall(vim.api.nvim_command, 'MasonUpdate') end },
			{'williamboman/mason-lspconfig.nvim'}, -- Optional
			-- Autocompletion
			{'hrsh7th/nvim-cmp'},     -- Required
			{'hrsh7th/cmp-nvim-lsp'}, -- Required
			{'L3MON4D3/LuaSnip'},     -- Required
			-- Snippets
		}},
     --"epwalsh/obsidian.nvim",

     --colorschemes
	{	"rose-pine/neovim", name = "rose-pine" },
}

local opts = {}

require("lazy").setup(plugins,opts)
