"  DISPLAY SETTINGS
if &compatible
	set nocompatible
endif
set background=dark
set nowrap
set scrolloff=2
set showmatch
set showmode
set showcmd
set ruler
set title
set wildmenu
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,*.svn
set laststatus=2
set cmdheight=1
set matchtime=2
set matchpairs+=<:>
set number relativenumber
set hlsearch
set incsearch
syntax on

" EDITOR SETTINGS
set signcolumn=number
set updatetime=300
set shortmess+=c
set encoding=utf-8
set ignorecase
set smartcase
set smartindent
set smarttab
set magic
set bs=indent,eol,start
set tabstop=4
set shiftwidth=4
set fileformat=unix
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
colorscheme gruvbox
filetype plugin on
filetype plugin indent on

" SYSTEM SETTINGS
set viminfo='200,\"500
set hidden
set history=50
set mouse=a

" KEY BINDINGS
let mapleader=","

nnoremap pyr :w !python <cr>
map <F10> :set paste<CR>
map <F9> :set nopaste<CR>
imap <F10> <C-O>:set paste<CR>
imap <F9> <nop>
set pastetoggle=<F9>

inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~# '\s'
endfunction

inoremap <silent><expr> <C-space> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

map <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <leader>cl  <Plug>(coc-codelens-action)

" Remap <C-f> and <C-b> for scroll float windows/popups from the official
" coc.nvim example config
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
autocmd BufEnter * if winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree() | quit | endif

nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>

" TAB & COMPLETITION SETTINGS
if has("autocmd")
	let zsh_is_sh=1
	autocmd BufEnter * lcd %:p:h
	augroup mysettings
		au FileType xslt,xml,css,html,xhtml,javascript,sh,config,c,cpp,cs,julia,lisp set smartindent shiftwidth=2 softtabstop=2 expandtab
		au FileType tex set wrap shiftwidth=2 softtabstop=2 expandtab
		au FileType python set tabstop=4 softtabstop=4 shiftwidth=4 cinwords=if,elif,else,for,while,try,except,finally,def,class
		au FileType rust set smartindent tabstop=4 softtabstop=4 shiftwidth=4 expandtab
		" inoremap { {}<ESC>i
		" inoremap [ []<ESC>i
		" inoremap ( ()<ESC>i
		" inoremap ' ''<ESC>i
		" inoremap " ""<ESC>i
	augroup END
endif

" PLUGINS
call plug#begin()
	Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
	Plug 'rust-lang/rust.vim'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'jmckiern/vim-shoot', {'do': '\"./install.py\" geckodriver' }
	Plug 'github/copilot.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
	Plug 'preservim/nerdtree'
	Plug 'Xuyuanp/nerdtree-git-plugin'
	Plug 'ryanoasis/vim-devicons'
	Plug 'tpope/vim-fugitive'
	Plug 'christoomey/vim-system-copy'
	Plug 'tpope/vim-surround'
	Plug 'jiangmiao/auto-pairs'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
call plug#end()

let g:airline_powerline_fonts = 1
let g:airline_solarized_bg='dark'
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#coc#error_symbol = ' '
let g:airline#extensions#coc#warning_symbol = ' '
let g:airline#extensions#coc#info_symbol = ' '
let g:airline#extensions#coc#success_symbol = ' '
let g:airline#extensions#coc#current_symbol = ' '
let g:airline#extensions#coc#show_coc_status = 1

function PythonConfig()
	hi semshiGlobal			ctermfg=blue		guifg=#0000ff
	nnoremap <F5> :w<ENTER>:!python %<ENTER>
	inoremap <F5> <ESC>:w<ENTER>:!python %<ENTER>
	vnoremap <F5> <ESC>:w<ENTER>:! !python<ENTER>
endfunction

function RustConfig()
	nnoremap <F4> :RustFmt<ENTER>:w<ENTER>:RustTest!<ENTER><CR>
	inoremap <F4> <ESC>:RustFmt<ENTER>:w<ENTER>:RustTest!<ENTER><CR>
	vnoremap <F4> <ESC>:RustFmt<ENTER>:w<ENTER>:RustTest!<ENTER><CR>
	nnoremap <F5> :RustFmt<ENTER>:w<ENTER>:!cargo run<ENTER>
	inoremap <F5> <ESC>:RustFmt<ENTER>:w<ENTER>:!cargo run<ENTER>
	vnoremap <F5> <ESC>:RustFmt<ENTER>:w<ENTER>:!cargo run<ENTER>
	" inoremap { {<ENTER>}<ESC>ko
endfunction

autocmd FileType python call PythonConfig()
autocmd FileType rust call RustConfig()
