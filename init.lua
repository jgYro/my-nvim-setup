-------------
-- Aliases --
-------------

local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local map = vim.api.nvim_set_keymap
local o = vim.opt
options = { noremap = true }

-------------
-- Options --
-------------

o.relativenumber = true
o.number = true
o.cursorline = true
o.cursorcolumn = true
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.autoindent = true
o.showcmd = false
o.wrap = false
o.updatetime = 300
o.swapfile = false
o.errorbells = false

--------------
-- Colorscheme
--------------

o.background = 'dark'
cmd([[colorscheme xcodedarkhc]])

--------------
-- Mappings --
--------------

-- Leader Key

g.mapleader = ' '

map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', options)
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', options)


-------------
-- Plugins --
-------------

-- Auto install plugin manager

local install_path = fn.stdpath('data')..'/site/pack/paqs/opt/paq-nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    cmd('!git clone --depth 1 https://github.com/savq/paq-nvim.git '..install_path)
end

cmd 'packadd paq-nvim'
local plug = require('paq-nvim').paq

-- Let the plugin manager manage itself

plug {'savq/paq-nvim', opt=true}

-----------------
-- Plugin list --
-----------------

plug {'vim-airline/vim-airline'}
plug {'vim-airline/vim-airline-themes'}
plug {'jiangmiao/auto-pairs'}
plug {'nvim-treesitter/nvim-treesitter'}

plug {'neovim/nvim-lspconfig'}
plug {'hrsh7th/nvim-compe'}

plug {'jremmen/vim-ripgrep'}
plug {'nvim-lua/popup.nvim'}
plug {'nvim-lua/plenary.nvim'}
plug {'nvim-telescope/telescope.nvim'}
plug {'nvim-telescope/telescope-fzf-native.nvim', run='make'}
plug {'junegunn/fzf'}

plug {'arzg/vim-colors-xcode'}

-- Auto install and clean plugins

require('paq-nvim').install()
require('paq-nvim').clean()

-------------------
-- Plugin Setups --
-------------------

require('telescope').setup {
    extensions = {
        fzf_writer = {
            minimum_grep_characters = 2,
            minimum_files_characters = 2,
            use_highlighter = true,
        }
    }
}
require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
        disable = {},
    },
    indent = {
        enable = false,
        disable = {},
    },
    ensure_installed = {
        "json",
        "python",
    }

}

-- Python langauge server setup
require('lspconfig').pylsp.setup{}

-- Compe stuff
require'compe'.setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;

    source = {
        path = true;
        buffer = true;
        calc = true;
        --vsnip = true;
        nvim_lsp = true;
        nvim_lua = true;
        spell = true;
        tags = true;
        --snippets_nvim = true;
        treesitter = true;
    };
}

local vim = vim
local opts = {
    noremap = true,
    silent = true,
    expr = true,
}
vim.api.nvim_set_keymap('i', '<cr>', "compe#confirm('<CR>')", opts)

-- LSP Mappings
map('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<cr>', options)
map('n', '<leader>lD', '<cmd>lua vim.lsp.buf.declaration()<cr>', options)
map('n', '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', options)
map('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<cr>', options)
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', options)
map('n', 'U', '<cmd>lua vim.lsp.buf.signature_help()<cr>', options)
map('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<cr>', options)
map('n', '<leader>ls', '<cmd>lua vim.lsp.buf.document_symbol()<cr>', options)
map('n', '<leader>lS', '<cmd>lua vim.lsp.buf.workspace_symbol()<cr>', options)
map('n', '<leader>lR', '<cmd>lua vim.lsp.buf.rename()<cr>', options)
map('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<cr>', options)
