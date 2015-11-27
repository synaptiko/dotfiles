filetype plugin indent on
syntax on
scriptencoding uft-8
set tabstop=2
set softtabstop=2
set shiftwidth=2
set noexpandtab
set virtualedit=onemore             " Allow for cursor beyond last character
set history=1000                    " Store a ton of history (default is 20)
set number                          " Line numbers on
set incsearch                       " Find as you type search
set hlsearch                        " Highlight search terms
set scrolljump=3                    " Lines to scroll when cursor leaves screen
set scrolloff=3                     " Minimum lines to keep above and below cursor
set nowrap                          " Do not wrap long lines
set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
set noshowmode
set relativenumber
set updatetime=750
set t_Co=256
set listchars=tab:  ,trail:·,nbsp:·
set list
let mapleader='\<SPACE>'						" TODO: Not working currently

call plug#begin('~/.config/nvim/plugged')
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'morhetz/gruvbox'
Plug 'kien/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
call plug#end()

let g:gruvbox_italic=1
let g:gruvbox_bold=1
let g:gruvbox_termcolors=256
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='soft'
let g:gruvbox_invert_selection=0
let g:gruvbox_sign_column='bg0'
set background=dark
colorscheme gruvbox

let g:airline_theme='gruvbox'
let g:airline_powerline_fonts=1

let g:gitgutter_sign_column_always=1
let g:gitgutter_realtime=1

let g:ctrlp_lazy_update = 350 " Set delay to prevent extra search
let g:ctrlp_max_files = 0
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

function! NumberToggle()
	if (&relativenumber == 1)
		set norelativenumber
	else
		set relativenumber
	endif
endfunc
" nnoremap <C-n> :call NumberToggle()<cr>

" The Silver Searcher
if executable('ag')
	" Use ag over grep
	set grepprg=ag\ --nogroup\ --nocolor

	" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
