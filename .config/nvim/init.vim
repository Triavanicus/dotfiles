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
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'yami-beta/asyncomplete-omni.vim'
Plug 'prabirshrestha/async.vim'

Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'prabirshrestha/asyncomplete-neosnippet.vim'

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
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:rubycomplete_buffer_loading=1
let g:rubycomplete_classes_in_global=1
let g:rubycomplete_rails=1
if executable('solargraph')
    autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'solargraph',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
            \ 'initialization_options': {"diagnostics": "true"},
            \ 'whitelist': ['ruby'],
            \ })
endif

map <leader>ce :edit ~/.config/nvim/init.vim<CR>
map <leader>cr :source ~/.config/nvim/init.vim<CR>
map <leader>wss :split<CR>
map <leader>wsv :vsplit<CR>
map <leader>wsh :split<CR>
map <leader>wq :q<CR>
map <leader>wQ :q!<CR>

" LSP mappings
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

" Have jk escape out of insert mode
imap jk <Esc>

" Tab completion
imap <expr> <Tab> pumvisible() ? "\<C-n>" :
  \ neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let g:endwise_no_mappings = v:true
imap <expr> <CR> pumvisible() ? 
  \ asyncomplete#close_popup() :
  \ "\<cr>\<Plug>DiscretionaryEnd"
imap <C-Space> <Plug>(asyncomplete_force_refresh)


call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
  \ 'name': 'omni',
  \ 'whitelist': ['*'],
  \ 'completor': function('asyncomplete#sources#omni#completor')}))

" Snippet
call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
  \ 'name': 'neosnippet',
  \ 'allowlist': ['*'],
  \ 'completor': function('asyncomplete#sources#neosnippet#completor')}))
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" Language Servers
lua << EOF
EOF

