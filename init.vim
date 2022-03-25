call plug#begin()

    " Coc
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Colorscheme and Syntax highlighting
    Plug 'gruvbox-community/gruvbox'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " NERDTree
    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'ryanoasis/vim-devicons'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'jistr/vim-nerdtree-tabs'

    " Telescope
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    " Airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    " Tag Bar
    Plug 'majutsushi/tagbar'

call plug#end()

filetype plugin indent on
syntax on
set encoding=UTF-8

" turn on line numbering
set number relativenumber
set cursorline
set cursorlineopt=number

" Fix slow insert
set timeout timeoutlen=100 ttimeoutlen=100

" More history
set history=8192

" sane editing
set tabstop=4
set shiftwidth=4
set softtabstop=4
"set scrolloff=8
set laststatus=2
set expandtab

" color scheme
colorscheme gruvbox
highlight Normal guibg=NONE ctermbg=NONE 
let g:lightline = { 'colorscheme': 'gruvbox' }
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

" file browser
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let NERDTreeMinimalUI = 1
let g:nerdtree_open = 0
map <C-n> :call NERDTreeToggle()<CR>
function NERDTreeToggle()
    NERDTreeTabsToggle
    if g:nerdtree_open == 1
        let g:nerdtree_open = 0
    else
        let g:nerdtree_open = 1
        wincmd p
    endif
endfunction

function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction
autocmd VimEnter * call StartUp()

" TagBar
map <C-t> :TagbarToggle<CR>

" Telescope 
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-l> <cmd>Telescope live_grep<cr>

" Coc
nmap <silent> gd <Plug>(coc-definition)
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

" Airline
set noshowmode
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#excludes = ["tagbar"]
let g:airline_theme = 'gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_section_z = airline#section#create(['windowswap', 'obsession', 'linenr', 'maxlinenr', '%3v'])

" split windows
nmap <space><Up> :wincmd k<CR>
nmap <space><Down> :wincmd j<CR>
nmap <space><Left> :wincmd h<CR>
nnoremap <space><Right> :wincmd l<CR>

" Move Between Tabs
nmap <tab> gt <CR>
nmap <s-tab> gT <CR>

" indent/unindent with tab/shift-tab
vmap <Tab> >gv
vmap <S-Tab> <gv
