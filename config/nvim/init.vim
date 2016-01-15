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
set listchars=tab:  ,trail:·,space:·,nbsp:·
set list
set title

let mapleader='\'
map <SPACE> <leader>

call plug#begin('~/.config/nvim/plugged')
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'morhetz/gruvbox'
Plug 'synaptiko/fzf'
Plug 'junegunn/fzf.vim'
Plug 'inside/vim-grep-operator'
Plug 'jamessan/vim-gnupg'
Plug 'artnez/vim-wipeout'
Plug 'rust-lang/rust.vim'
" Plug 'justinmk/vim-sneak' " TODO maybe later? but it seems to be useful
" Plug 'easymotion/vim-easymotion' " TODO this is also interesting... but maybe quite complex
call plug#end()

" The Silver Searcher
if executable('ag')
	" Use ag over grep
	set grepprg=ag\ --nogroup\ --nocolor
endif

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
let g:airline#extensions#whitespace#enabled=0

let g:gitgutter_sign_column_always=1
let g:gitgutter_realtime=1

let g:fzf_command_prefix='Fzz'
let g:fzf_layout={ 'window': 'topleft 14new' }

nmap <leader>g <Plug>GrepOperatorOnCurrentDirectory
vmap <leader>g <Plug>GrepOperatorOnCurrentDirectory

" nmap <silent> <C-p> :FzzFiles<CR>
" nmap <silent> <C-e> :FzzBuffers<CR>
" nmap <silent> <M-R> :FzzBLines<CR>
nmap <silent> <leader>j :FzzFiles<CR>
nmap <silent> <leader>k :FzzBuffers<CR>
nmap <silent> <leader>l :FzzBLines<CR>

nmap <silent> <leader>s :w<CR>
" TODO add t for visual mode, so it will pre-search term in FzzFiles
nmap <silent> <leader>t :tabe<CR>:FzzFiles<CR>

" Previous solution: nnoremap <C-l> :let @/ = ""<CR><C-l>
" More solutions here: http://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting
nmap <silent> <C-l> :nohlsearch<CR>

" TODO remap also Tab/S-Tab in normal and visual mode?
imap <Tab> <C-t>
imap <S-Tab> <C-d>

" Better mapping related to the terminal and window movements
tnoremap <Esc> <Esc><C-\><C-n>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Useful abbreviations
ab fixme // FIXME jprokop:
ab todo // TODO jprokop:
ab clog console.log();<Left><Left>
ab dbg debugger;

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " Disable auto-insertion of comments (http://vim.wikia.com/wiki/Disable_automatic_comment_insertion)

" cindent is terrible, smartindent is enough for most cases (and specialized js plugins are terribly complex)
" TODO someday look at this: http://stackoverflow.com/a/20127451
autocmd FileType javascript setlocal nocindent smartindent

" Following ensures that fzf will be always set correctly, even when run from nvim-wrapper
" (see https://github.com/fmoralesc/neovim-gnome-terminal-wrapper/pull/9#issuecomment-160473798)
let $FZF_DEFAULT_COMMAND='ag -g ""'
let $FZF_DEFAULT_OPTS='--reverse --inline-info'

" Useful for highlight introspection and overrides:
" http://yanpritzker.com/2012/04/17/how-to-change-vim-syntax-colors-that-are-annoying-you/
" nmap ,hi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>
