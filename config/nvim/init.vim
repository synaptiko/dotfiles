scriptencoding uft-8
set tabstop=2
set softtabstop=2
set shiftwidth=2
set noexpandtab
set history=1000                    " Store a ton of history (default is 20)
set number                          " Line numbers on
set ignorecase                      " Ignore case-sensitive search
set smartcase                       " And switch on smart-case search
set incsearch                       " Find as you type search
set hlsearch                        " Highlight search terms
set scrolljump=3                    " Lines to scroll when cursor leaves screen
set scrolloff=3                     " Minimum lines to keep above and below cursor
set nowrap                          " Do not wrap long lines
set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
set iskeyword+=-                    " Append hyphens, they are quite often used in SCSS and similar
set termguicolors                   " https://github.com/neovim/neovim/wiki/Following-HEAD#20160511
set noshowmode
set relativenumber
set updatetime=750
set listchars=tab:  ,trail:·,space:·,nbsp:·
set list
set title

let mapleader='\'
map <SPACE> <leader>

call plug#begin('~/.config/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'synaptiko/mintabline'
Plug 'synaptiko/fzf'
Plug 'junegunn/fzf.vim'
Plug 'jamessan/vim-gnupg'
Plug 'artnez/vim-wipeout'
Plug 'rust-lang/rust.vim'
Plug 'mhinz/vim-grepper'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'sirtaj/vim-openscad'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
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
let g:gruvbox_contrast_light='hard'
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

nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

nmap <silent> <leader>j :FzzFiles<CR>
nmap <silent> <leader>k :FzzBuffers<CR>
nmap <silent> <leader>l :FzzBLines<CR>

nmap <silent> <leader>s :w<CR>
nmap <silent> <leader>t :tabe<CR>
nmap <silent> <leader>q :q<CR>
nmap <silent> <leader>[ <Plug>GitGutterNextHunk
nmap <silent> <leader>] <Plug>GitGutterPrevHunk

" Previous solution: nnoremap <C-l> :let @/ = ""<CR><C-l>
" More solutions here: http://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting
nmap <silent> <C-l> :nohlsearch<CR>

nmap <Tab> >>
nmap <S-Tab> <<
vmap <Tab> >gv
vmap <S-Tab> <gv
imap <Tab> <C-t>
imap <S-Tab> <C-d>

nmap <A-i> <PageUp>
nmap <A-m> <PageDown>

vmap <silent> <leader>c "*ygv"+y
nmap <silent> <leader>c "*yy"+yy
nmap <silent> <leader>v :set paste<CR>a<C-r>*<Esc>:set nopaste<CR>
nmap <silent> <leader>V :set paste<CR>o<C-r>*<Esc>:set nopaste<CR>

" Better mapping related to the terminal and window movements (derived from i3)
tnoremap <Esc> <Esc><C-\><C-n>
tnoremap <leader>wj <C-\><C-n><C-w>h
tnoremap <leader>wk <C-\><C-n><C-w>j
tnoremap <leader>wl <C-\><C-n><C-w>k
tnoremap <leader>w; <C-\><C-n><C-w>l
nnoremap <leader>wj <C-w>h
nnoremap <leader>wk <C-w>j
nnoremap <leader>wl <C-w>k
nnoremap <leader>w; <C-w>l

" Easier jumping amongst first 9 tabs
nmap <silent> <leader>1 1gt
nmap <silent> <leader>2 2gt
nmap <silent> <leader>3 3gt
nmap <silent> <leader>4 4gt
nmap <silent> <leader>5 5gt
nmap <silent> <leader>6 6gt
nmap <silent> <leader>7 7gt
nmap <silent> <leader>8 8gt
nmap <silent> <leader>9 9gt

" Tabs can be easily moved (similar to Ctrl+Shift+PageDown/Up)
nmap <silent> mt :tabm +<CR>
nmap <silent> mT :tabm -<CR>

" Better search next/prev (always watch one place in long files)
nnoremap <silent> n nzz
nnoremap <silent> N Nzz

" Better NERDTree menu mapping (m has delay because of Bookmarks plugin)
nnoremap <silent> <leader>m :call nerdtree#ui_glue#invokeKeyMap("m")<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Avoid accidental unexpected behavior (Ctrl+Z in neovim-gnome-terminal-wrapper or Ctrl+U in insert mode)
nmap <C-z> <nop>
vmap <C-z> <nop>
imap <C-u> <nop>

" Useful abbreviations
ab fixme // FIXME jprokop:
ab todo // TODO jprokop:
ab clog console.log();<Left><Left>
ab dbg debugger;

augroup configgroup
	autocmd!
	" Disable auto-insertion of comments (http://vim.wikia.com/wiki/Disable_automatic_comment_insertion)
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
	" cindent is terrible, smartindent is enough for most cases (and specialized js plugins are terribly complex)
	" TODO someday look at this: http://stackoverflow.com/a/20127451
	autocmd FileType javascript setlocal nocindent smartindent
	" python has whitespace significant philosophy, so don't render spaces visible
	autocmd FileType python setlocal nolist
augroup END

" Following ensures that fzf will be always set correctly, even when run from nvim-wrapper
" (see https://github.com/fmoralesc/neovim-gnome-terminal-wrapper/pull/9#issuecomment-160473798)
let $FZF_DEFAULT_COMMAND='ag -g ""'
let $FZF_DEFAULT_OPTS='--reverse --inline-info'

" Useful for highlight introspection and overrides:
" http://yanpritzker.com/2012/04/17/how-to-change-vim-syntax-colors-that-are-annoying-you/
" nmap ,hi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>

" Better colors in a terminal inside Neovim (https://github.com/neovim/neovim/issues/4436)
let g:terminal_color_0  = '#282828'
let g:terminal_color_1  = '#cc241d'
let g:terminal_color_2  = '#98971a'
let g:terminal_color_3  = '#d79921'
let g:terminal_color_4  = '#458588'
let g:terminal_color_5  = '#b16286'
let g:terminal_color_6  = '#689d6a'
let g:terminal_color_7  = '#a89984'
let g:terminal_color_8  = '#928374'
let g:terminal_color_9  = '#fb4934'
let g:terminal_color_10 = '#b8bb26'
let g:terminal_color_11 = '#fabd2f'
let g:terminal_color_12 = '#83a598'
let g:terminal_color_13 = '#d3869b'
let g:terminal_color_14 = '#8ec07c'
let g:terminal_color_15 = '#ebdbb2'

" Default Fzf's status line is not useful for me
function! s:fzf_statusline()
	setlocal statusline=·
endfunction
autocmd! User FzfStatusLine call <SID>fzf_statusline()

" Update appearance of TabLine (according to gruvbox theme)
highlight TabLineSel guifg=#1d2021 guibg=#a89984

" Convenient 'Mr.Proper for tabs and buffers' function
function! ClearTabsAndBuffers()
	tabedit
	tabonly
	sleep 10m " wait 10ms to avoid gitgutter errors
	Wipeout
endfunction
nmap <leader>Q :call ClearTabsAndBuffers()<CR>
