nnoremap <SPACE> <Nop>
" possible remap if caps lock cannot be remapped

let &shell = has('win32') ? 'powershell' : 'pwsh'
set shellquote= shellpipe=\| shellxquote=
set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
set shellredir=\|\ Out-File\ -Encoding\ UTF8
tnoremap <Esc> <C-\><C-n>
nnoremap <A-v> <C-v>
let mapleader=" "
set encoding=utf-8
set cmdheight=2
set rnu
set nu
set cursorline
set cursorcolumn
syntax enable
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set noswapfile
set noerrorbells
set showcmd
set updatetime=300
set noshowcmd
set noruler
set nowrap

"kite stuff
"let g:kite_tab_complete=1

"function! s:check_back_space() abort
	"let col = col('.') - 1
	"return !col || getline('.')[col - 1] =~ '\s'
"endfunction

"inoremap <silent><expr> <Tab>
	"\ pumvisible() ? "\<C-n>" :
	"\ <SID>check_back_space() ? "\<Tab>" :
	"\ kite#completion#autocomplete()

"autocmd CompleteDone * if !pumvisible() | pclose | endif
"set belloff+=ctrlg  " if vim beeps during completion

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

call plug#begin()
" js/ts intellisense
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

nnoremap <silent> K :call CocAction('doHover')<CR>

function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#float#has_float() == 0)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(500, 'ShowDocIfNoDiagnostic')
endfunction

autocmd CursorHoldI *.js,*.jsx,*.tsx :call <SID>show_hover_doc()
autocmd CursorHold *.js,*.jsx,*.tsx :call <SID>show_hover_doc()

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gv :vsp<CR><Plug>(coc-definition)<C-W>L
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nnoremap <silent> <leader>e :<C-u>CocList diagnostics<cr>

nmap <leader>do <Plug>(coc-codeaction)

nmap <leader>rn <Plug>(coc-rename)

"typescript/react stuff" coc extensions
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier']
"------------------------ VIM TSX ------------------------
" by default, if you open tsx file, neovim does not show syntax colors
" vim-tsx will do all the coloring for jsx in the .tsx file
Plug 'ianks/vim-tsx'
"------------------------ VIM TSX ------------------------
" by default, if you open tsx file, neovim does not show syntax colors
" typescript-vim will do all the coloring for typescript keywords
Plug 'leafgarland/typescript-vim'

"powershell stuff
Plug 'pprovost/vim-ps1'

"file manager i never use
Plug 'preservim/NERDTree'
nnoremap <leader>n :NERDTreeFocus<CR>
nmap <leader>ne :NERDTree<cr>
nnoremap <C-t> :NERDTreeToggle<CR>

"telescope stuff
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>



"status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"allows git commands
Plug 'tpope/vim-fugitive'

"shows git changes
Plug 'airblade/vim-gitgutter'

"autopair
Plug 'jiangmiao/auto-pairs'

"color scheme
Plug 'gruvbox-community/gruvbox'

"awesome snippets
Plug 'SirVer/Ultisnips'

"sit on the tree
Plug 'nvim-treesitter/nvim-treesitter'

"ripgrep
Plug 'jremmen/vim-ripgrep'

call plug#end()

autocmd vimenter * ++nested colorscheme gruvbox

" cycle through snippet tabs
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-x>'
let g:UltiSnipsJumpBackwardTrigger = '<C-z>'

call plug#end()

nnoremap <silent> <Leader>f :Rg<CR>

command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
