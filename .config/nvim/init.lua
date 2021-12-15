require 'packages'
local cmp = require'cmp'
local nvim_lsp = require('lspconfig')
local lspkind = require('lspkind')

local api = vim.api

local function t(str)
    return api.nvim_replace_termcodes(str, true, true, true)
end

local function map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = opts.silent or true
    opts.noremap = opts.noremap or true
    api.nvim_set_keymap(mode, lhs, rhs, opts)
end

local function imap(lhs, rhs, opts)
    map('i', lhs, rhs, opts)
end

local function nmap(lhs, rhs, opts)
    map('n', lhs, rhs, opts)
end

require'lualine'.setup{
    options = { theme = 'gruvbox' }
}

cmp.setup({
    formatting = {
        format = lspkind.cmp_format({
            preset = 'default',
            with_text = false, -- do not show text alongside icons
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        })
    },
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'path' },
        --{ name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

local basic_lsp = {'solargraph', 'bashls'}
--require'lspconfig'.solargraph.setup{}
--require'lspconfig'.bashls.setup{cmd = {"bash-language-server", "start"}}
for _, lsp in ipairs(basic_lsp) do
    nvim_lsp[lsp].setup{}
end

vim.opt.background = 'dark'
vim.cmd'colorscheme gruvbox'

vim.g.mapleader = ' '

vim.opt.clipboard = 'unnamedplus'
vim.opt.expandtab = true
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.showmode = false
vim.cmd'set completeopt=menu,menuone,noselect'
-- vim.opt.formatoptions = 'jql' -- Set in ~/.config/nvim/after/ftplugin/lua.vim

-- Language: Ruby
vim.cmd[[
    autocmd FileType ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2
]]

nmap('<leader>q', ':bd<CR>')

imap('jk', '<ESC>')
imap('kj', '<ESC>')
imap('jj', '<ESC>')

-- HJKL Move between panes
nmap('<C-h>', ':wincmd h<CR>')
nmap('<C-j>', ':wincmd j<CR>')
nmap('<C-k>', ':wincmd k<CR>')
nmap('<C-l>', ':wincmd l<CR>')
nmap('<leader>wh', ':split<CR>')
nmap('<leader>wv', ':vsplit<CR>')
nmap('<leader>nh', ':noh<CR>')


nmap('<leader>ce', ':edit ~/.config/nvim/init.lua<CR>')
nmap('<leader>cr', ':source ~/.config/nvim/init.lua<CR>')

function _G.smart_tab()
    return vim.fn.pumvisible == 1 and t'C-n>' or t'<Tab>'
end

function _G.smart_shift_tab()
   return vim.fn.pumvisible() == 1 and t'<C-p' or t'<S-Tab>'
end

--imap('<Tab>', 'v:lua.smart_tab()', { expr = true })
--imap('<S-Tab>', 'v:lua.smart_shift_tab()', { expr = true })
--imap('<C-Space>', '<C-x><C-o>')
