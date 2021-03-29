"shared init.vim for both MacOSX and Windows

" make sure package manager loads initially if files are not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"if not windows
tnoremap <Esc> <C-\><C-n>

"allow terminal to open with .bash_profile
nnoremap <SPACE> <Nop>
" possible remap if caps lock cannot be remapped for windows
" :imap ii <Esc>
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

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

call plug#begin()
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
Plug 'powerline/fonts'
" air-line
let g:airline_powerline_fonts = 1
let g:airline_theme='violet'

"allows git commands
Plug 'tpope/vim-fugitive'
"shows git changes
Plug 'airblade/vim-gitgutter'
"go to any word like vimimum f command
Plug 'easymotion/vim-easymotion'

"python stuff
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'davidhalter/jedi'
Plug 'jiangmiao/auto-pairs'

"color scheme
Plug 'gruvbox-community/gruvbox'
 
"awesome snippets
Plug 'SirVer/Ultisnips'

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
"------------------------ THEME ------------------------
" most importantly you need a good color scheme to write good code :D
Plug 'dikiaap/minimalist'
" == VIMPLUG END ================================
" == AUTOCMD ================================ 
" by default .ts file are not identified as typescript and .tsx files are not
" identified as typescript react file, so add following
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
" == AUTOCMD END ================================
"dart stff
Plug 'natebosch/dartlang-snippets'
Plug 'dart-lang/dart-vim-plugin'
let dart_format_on_save = 1
let dart_style_guide = 2

let g:coc_force_debug = 1

autocmd vimenter * ++nested colorscheme gruvbox

" cycle through snippet tabs
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-x>'
let g:UltiSnipsJumpBackwardTrigger = '<C-z>'

" codeaction 
"Example: <leader>aap for current paragraph, <leader>aw for the current word
" Wrap with widget, center, etc
xmap <leader>a  <Plug>(coc-codeaction-selected)

nmap <leader>a  <Plug>(coc-codeaction-selected)

nmap <silent> gs :call CocAction('jumpDefinition', 'vsplit')<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nmap <leader>rn <Plug>(coc-rename)
call plug#end()
"set shell=/bin/bash\ --login has bug with airline :( otherwise loads .bash_profile
