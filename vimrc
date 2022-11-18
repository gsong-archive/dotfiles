set autoread
set directory=~/.vim/swapdir,$TMPDIR,/var/tmp,/tmp
set encoding=utf-8
set fileencodings=
set hidden          "Remember undo after quitting
set ls=2            "Alway show status line
set modeline        "Last lines in document sets vim mode
set modelines=3     "Number lines checked for modelines
set nobackup        "Do not keep a backup file
set nocompatible    "Use vim defaults
set nostartofline   "Don't jump to first character when paging
set novisualbell    "Turn off visual bell
set number          "Show line numbers
set ruler           "Show the cursor position all the time
set scrolloff=3     "Keep 3 lines when scrolling
set shortmess=atI   "Abbreviate messages
set showcmd         "Display incomplete commands
set sidescroll=1    "Better horizontal scrolling
set sidescrolloff=5 "Horizontal scroll offset
set undodir=~/.vim/undodir,$TMPDIR,/var/tmp,/tmp
set visualbell t_vb=    "Turn off error beep/flash
set whichwrap=b,s,h,l,<,>,[,]   "Move freely between files

"SOFT WRAPS See <http://vim.wikia.com/wiki/Word_wrap_without_line_breaks>
set wrap
set linebreak
let &showbreak = "> "
set nolist          "list disables linebreak
set textwidth=0
set wrapmargin=0

setlocal spelllang=en_us

syntax enable

"vim-airline
if !exists('g:airline_symbols')
  let g:airline_powerline_fonts = 1
  let g:airline_theme = 'tomorrow'
  let g:airline_section_x = ''
  let g:airline_section_y = ''
endif
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

"SEARCH OPTIONS
set ignorecase      "Case insensitive search
set incsearch       "Incremental search
set hlsearch        "Highlight search
set smartcase       "Case sensitive search if upper case chars are used
set tags=./tags;/   "Search up the tree for ctags"

"INDENTATION OPTIONS
set autoindent      "Auto-indent new lines
set nocindent       "Use smartindent instead
set expandtab       "Tabs are converted to spaces
set shiftwidth=2    "Tab width for indentation
set smartindent     "Smart indentation
set tabstop=2       "Tab width

filetype plugin indent on

filetype plugin on
set omnifunc=syntaxcomplete#Complete

highlight SpellBad term=underline gui=undercurl guisp=Orange

" Ale
let g:ale_linters = {'javascript': ['eslint', 'flow']}
let g:ale_markdown_markdownlint_options = '--disable MD013'
let g:ale_fixers = {
  \ '*': ['prettier'],
  \ 'javascript': ['eslint'],
  \ 'python': ['isort', 'black']
\}
let g:ale_fix_on_save = 1

" NerdTree
let NERDTreeIgnore=['\.DS_Store', '\.git$', '\.pyc', '\.swo$', '\.swp$', '\~$']
let NERDTreeChDirMode=2
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'

" CtrlP
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 'rw'

" Markdown
" let g:vim_markdown_folding_disabled=1
set nofoldenable

" localvimrc
let g:localvimrc_sandbox = 0
let g:localvimrc_persistent = 2
let g:localvimrc_event = ["BufWinEnter", "BufReadPre"]

" Prettier
let g:prettier#config#arrow_parens = 'always'

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" YCM
let g:ycm_auto_hover = ''
nmap <leader>D <plug>(YCMHover)
set completeopt-=preview
nnoremap <c-]> :YcmCompleter GoTo<CR>
let g:ycm_filetype_blacklist =
      \ get( g:, 'ycm_filetype_blacklist', {
      \   'tagbar': 1,
      \   'notes': 1,
      \   'netrw': 1,
      \   'unite': 1,
      \   'text': 1,
      \   'vimwiki': 1,
      \   'pandoc': 1,
      \   'infolog': 1,
      \   'leaderf': 1,
      \   'mail': 1
      \ } )

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" indent-guides
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

" jsx
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" Marked.app integration
:nnoremap <leader>m :MarkedOpen!<cr>

if has('gui_running')
    set background=light
    set guifont=SauceCodeProNerdFontComplete-Regular:h14
else
    let g:solarized_termcolors=256
    set background=dark
endif

try
    colorscheme solarized
catch
endtry

if has("autocmd")
    " autoindent with two spaces, always expand tabs
    autocmd FileType python setlocal ai sw=4 sts=4 et
    autocmd FileType javascript,markdown,python setlocal cc=80
    autocmd VimEnter * call Plugins()
    " prettier
    autocmd FileType javascript.jsx,javascript.mjs,javascript setlocal formatprg=prettier\ --stdin
    autocmd FileType markdown setlocal spell
endif

"Highlight trailing spaces http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
augroup WhitespaceMatch
  " Remove ALL autocommands for the WhitespaceMatch group.
  autocmd!
  autocmd BufWinEnter * let w:whitespace_match_number =
        \ matchadd('ExtraWhitespace', '\s\+$')
  autocmd InsertEnter * call s:ToggleWhitespaceMatch('i')
  autocmd InsertLeave * call s:ToggleWhitespaceMatch('n')
augroup END
function! s:ToggleWhitespaceMatch(mode)
  let pattern = (a:mode == 'i') ? '\s\+\%#\@<!$' : '\s\+$'
  if exists('w:whitespace_match_number')
    call matchdelete(w:whitespace_match_number)
    call matchadd('ExtraWhitespace', pattern, 10, w:whitespace_match_number)
  else
    " Something went wrong, try to be graceful.
    let w:whitespace_match_number =  matchadd('ExtraWhitespace', pattern)
  endif
endfunction

function! Plugins()

    if exists(":NERDTree")
        map <c-n> :NERDTreeToggle<CR>
        let NERDTreeIgnore=['\~$', '.pyc', '.egg-info', '.class']
    endif

    " Toggle pyflakes quickfix
    let g:pyflakes_use_quickfix=1
    function! TogglePyflakesQf()
        if (g:pyflakes_use_quickfix==0)
        let g:pyflakes_use_quickfix=1
    else
        let g:pyflakes_use_quickfix=0
    endif
    endfunction
    command! PyflakesQf call TogglePyflakesQf()

endfunction
