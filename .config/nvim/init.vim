" Install vim-plug if not isntalled
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" Specify a directory for plugins
call plug#begin(stdpath('data') . '/plugged')

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'vim-ruby/vim-ruby'

" TMUX integration
Plug 'christoomey/vim-tmux-navigator'

" Fuzzy find
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Autocompletion
"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'prabirshrestha/vim-lsp'
"Plug 'prabirshrestha/asyncomplete-lsp.vim'
"Plug 'prabirshrestha/asyncomplete-file.vim'
"Plug 'yami-beta/asyncomplete-omni.vim'
"Plug 'prabirshrestha/async.vim'

"Plug 'Shougo/neosnippet'
"Plug 'Shougo/neosnippet-snippets'
"Plug 'prabirshrestha/asyncomplete-neosnippet.vim'

Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-endwise'

Plug 'neovim/nvim-lspconfig'

" UI Themes
Plug 'morhetz/gruvbox'
call plug#end()

let mapleader = ";"
command! Sw :execute ':silent w !sudo tee % >/dev/null' | :edit!

syntax on
colorscheme gruvbox
highlight! link LspDiagnosticsDefaultError CocDiagnosticsError
highlight! link LspDiagnosticsDefaultInformation CocDiagnosticsInfo
highlight! link LspDiagnosticsDefaultWarning CocDiagnosticsWarning
highlight! link LspDiagnosticsDefaultHint CocDiagnosticsHint
highlight! link LspErrorText CocErrorSign
highlight! link LspInformationText CocInfoSign
highlight! link LspWarningText CocWarningSign
highlight! link LspHintText CocHintSign
highlight! clear LspErrorHighlight
highlight! clear LspInformationHighlight
highlight! clear LspWarningHighlight
highlight! clear LspHintHighlight
highlight! LspErrorHighlight gui=undercurl
highlight! LspInformationHighlight gui=undercurl
highlight! LspWarningHighlight gui=undercurl
highlight! LspHintHighlight gui=undercurl

" Set the background for transparency
hi Normal guibg=NONE ctermbg=NONE

set nocompatible
set nowrap
set number relativenumber
set colorcolumn=81
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set incsearch
set termguicolors
set clipboard=unnamed

" Language: Markdown
nmap <leader>mpt <Plug>MarkdownPreviewToggle
nmap <leader>mps <Plug>MarkdownPreview
nmap <leader>mpq <Plug>MarkdownPreviewStop
augroup Markdown
    autocmd!
    autocmd FileType markdown set wrap
    autocmd FileType markdown set linebreak
augroup END

" FZF
nnoremap <silent> <leader>b :Buffers<cr>
nnoremap <silent> <leader><S-f> :Files<cr>
nnoremap <silent> <leader>f :Rg<cr>
nnoremap <silent> <leader>/ :BLines<cr>
nnoremap <silent> <leader>' :Marks<cr>
nnoremap <silent> <leader>g :Commits<cr>
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

let g:diagnostic_enable_virtual_text=0

" Language: Ruby
autocmd FileType ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
"let g:rubycomplete_buffer_loading=1
"let g:rubycomplete_classes_in_global=1
"let g:rubycomplete_rails=1
"if executable('solargraph')
"    autocmd User lsp_setup call lsp#register_server({
"            \ 'name': 'solargraph',
"            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
"            \ 'initialization_options': {"diagnostics": "true"},
"            \ 'whitelist': ['ruby'],
"            \ })
"endif

map <leader>ce :edit ~/.config/nvim/init.vim<CR>
map <leader>cr :source ~/.config/nvim/init.vim<CR>
map <leader>wss :split<CR>
map <leader>wsv :vsplit<CR>
map <leader>wsh :split<CR>
map <leader>wq :q<CR>
map <leader>wQ :q!<CR>

" LSP mappings
"nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
"nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
"nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
"nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
"nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
"nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
"nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
"nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
"nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

" Have jk escape out of insert mode
imap jk <Esc>

" Tab completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>
"imap <expr> <Tab> pumvisible() ? '\<C-n>' :
"  \ neosnippet#expandable_or_jumpable() ?
"  \ '\<Plug>(neosnippet_expand_or_jump)' : '\<Tab>'
"inoremap <expr> <S-Tab> pumvisible() ? '\<C-p>' : '\<S-Tab>'
"let g:endwise_no_mappings = v:true
"imap <expr> <CR> pumvisible() ? 
"  \ asyncomplete#close_popup() :
"  \ '\<cr>\<Plug>DiscretionaryEnd'
"imap <C-Space> <Plug>(asyncomplete_force_refresh)


"call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
"  \ 'name': 'omni',
"  \ 'whitelist': ['*'],
"  \ 'completor': function('asyncomplete#sources#omni#completor')}))

" Snippet
"call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
"  \ 'name': 'neosnippet',
"  \ 'allowlist': ['*'],
"  \ 'completor': function('asyncomplete#sources#neosnippet#completor')}))
"imap <C-k> <Plug>(neosnippet_expand_or_jump)
"smap <C-k> <Plug>(neosnippet_expand_or_jump)
"xmap <C-k> <Plug>(neosnippet_expand_target)

" Language Servers
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
    local opts = { noremap=true, silent=true }
    
    -- See `:help vim.lsp.*` for documentation of the functions below
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to call 'setup' on multiple servers and map buffer local keybindings
-- when language server attaches.

local servers = { "solargraph" }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {
            debounce_text_chages = 150,
            }
        }
end
EOF

