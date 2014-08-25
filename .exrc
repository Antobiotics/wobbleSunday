if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <D-BS> 
inoremap <M-BS> 
inoremap <M-Down> }
inoremap <D-Down> <C-End>
inoremap <M-Up> {
inoremap <D-Up> <C-Home>
noremap! <M-Right> <C-Right>
noremap! <D-Right> <End>
noremap! <M-Left> <C-Left>
noremap! <D-Left> <Home>
inoremap <silent> <Plug>NERDCommenterInsert  <BS>:call NERDComment('i', "insert")
nmap <silent>  :wincmd h
vmap <silent>  :call TransCopy(visualmode(), 1)
nmap <silent>  :w !pbtranscopy
nmap <silent>  :wincmd l
map  :NERDTreeToggle
vmap <silent>  x:call TransPaste(visualmode())
nmap <silent>  :set paste:let b:prevlen = len(getline(0,'$'))!!pbtranspaste:set nopaste:set fileformat=unixmv:exec 'normal ' . (len(getline(0,'$')) - b:prevlen) . 'j'V`v
map  w
nmap <silent>  :wincmd k
nnoremap   <PageDown>
vmap <silent> # :call ToggleBlock()
nmap <silent> # :call ToggleComment()j0
nmap $$ $<i}``
nmap %% $>i}``
map ,x <Plug>XMLMatchToggle
nmap ,ca <Plug>NERDCommenterAltDelims
xmap ,cu <Plug>NERDCommenterUncomment
nmap ,cu <Plug>NERDCommenterUncomment
xmap ,cb <Plug>NERDCommenterAlignBoth
nmap ,cb <Plug>NERDCommenterAlignBoth
xmap ,cl <Plug>NERDCommenterAlignLeft
nmap ,cl <Plug>NERDCommenterAlignLeft
nmap ,cA <Plug>NERDCommenterAppend
xmap ,cy <Plug>NERDCommenterYank
nmap ,cy <Plug>NERDCommenterYank
xmap ,cs <Plug>NERDCommenterSexy
nmap ,cs <Plug>NERDCommenterSexy
xmap ,ci <Plug>NERDCommenterInvert
nmap ,ci <Plug>NERDCommenterInvert
nmap ,c$ <Plug>NERDCommenterToEOL
xmap ,cn <Plug>NERDCommenterNested
nmap ,cn <Plug>NERDCommenterNested
xmap ,cm <Plug>NERDCommenterMinimal
nmap ,cm <Plug>NERDCommenterMinimal
xmap ,c  <Plug>NERDCommenterToggle
nmap ,c  <Plug>NERDCommenterToggle
xmap ,cc <Plug>NERDCommenterComment
nmap ,cc <Plug>NERDCommenterComment
nmap ,ihn :IHN
nmap ,is :IHS:A
nmap ,ih :IHS
nmap ,P <Plug>yankstack_substitute_newer_paste
nmap ,p <Plug>yankstack_substitute_older_paste
nmap // :call NormalizedSearch( input('//', "") )
nmap :W :w
nmap :Q :q
nmap :WQ :wq
nmap :wQ :wq
nmap :Wq :wq
nmap :te :tabe
nmap <silent> ;c :silent call Toggle_CursorColumn('flip')
nmap <silent> ;r :set cursorline!
nmap ;vv :next ~/.vim/plugin/
nmap <silent> ;v :next $MYVIMRC
vmap <expr> < KeepVisualSelection("<")
nnoremap <silent> < Leader>- :exe "resize " . (winheight(0) * 2/3)
vmap <expr> > KeepVisualSelection(">")
vnoremap <silent> A A=TemporaryColumnMarkerOn()
vnoremap <silent> I I=TemporaryColumnMarkerOn()
nmap <silent> U :call ToggleUTF8()
nmap XX 1GdG
vmap aa VGo1G
nmap gx <Plug>NetrwBrowseX
nnoremap j gj
nnoremap k gk
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)
noremap <M-Down> }
noremap <D-Down> <C-End>
noremap <M-Up> {
noremap <D-Up> <C-Home>
noremap <D-Right> <End>
noremap <D-Left> <Home>
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
nnoremap <Plug>FireplaceSource :Source 
nnoremap <silent> <Plug>FireplaceCountPrint :Eval
xnoremap <silent> <Plug>NERDCommenterUncomment :call NERDComment("x", "Uncomment")
nnoremap <silent> <Plug>NERDCommenterUncomment :call NERDComment("n", "Uncomment")
xnoremap <silent> <Plug>NERDCommenterAlignBoth :call NERDComment("x", "AlignBoth")
nnoremap <silent> <Plug>NERDCommenterAlignBoth :call NERDComment("n", "AlignBoth")
xnoremap <silent> <Plug>NERDCommenterAlignLeft :call NERDComment("x", "AlignLeft")
nnoremap <silent> <Plug>NERDCommenterAlignLeft :call NERDComment("n", "AlignLeft")
nnoremap <silent> <Plug>NERDCommenterAppend :call NERDComment("n", "Append")
xnoremap <silent> <Plug>NERDCommenterYank :call NERDComment("x", "Yank")
nnoremap <silent> <Plug>NERDCommenterYank :call NERDComment("n", "Yank")
xnoremap <silent> <Plug>NERDCommenterSexy :call NERDComment("x", "Sexy")
nnoremap <silent> <Plug>NERDCommenterSexy :call NERDComment("n", "Sexy")
xnoremap <silent> <Plug>NERDCommenterInvert :call NERDComment("x", "Invert")
nnoremap <silent> <Plug>NERDCommenterInvert :call NERDComment("n", "Invert")
nnoremap <silent> <Plug>NERDCommenterToEOL :call NERDComment("n", "ToEOL")
xnoremap <silent> <Plug>NERDCommenterNested :call NERDComment("x", "Nested")
nnoremap <silent> <Plug>NERDCommenterNested :call NERDComment("n", "Nested")
xnoremap <silent> <Plug>NERDCommenterMinimal :call NERDComment("x", "Minimal")
nnoremap <silent> <Plug>NERDCommenterMinimal :call NERDComment("n", "Minimal")
xnoremap <silent> <Plug>NERDCommenterToggle :call NERDComment("x", "Toggle")
nnoremap <silent> <Plug>NERDCommenterToggle :call NERDComment("n", "Toggle")
xnoremap <silent> <Plug>NERDCommenterComment :call NERDComment("x", "Comment")
nnoremap <silent> <Plug>NERDCommenterComment :call NERDComment("n", "Comment")
nmap <silent> <BS><BS> mz:%s/\s\+$//g`z:nohlsearch
nmap <silent> <BS> :nohlsearch | call Toggle_CursorColumn('off')
map <F5> :call RunProcessing()
noremap <M-Right> <C-Right>
noremap <M-Left> <C-Left>
nnoremap <C-Right> :tabnext
nnoremap <C-Left> :tabprevious
vmap <BS> x
imap <silent>  =VCopy('down')
imap <silent>  =VCopy('up')
imap ,ihn :IHN
imap ,is :IHS:A
imap ,ih :IHS
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set autoread
set autowrite
set background=dark
set backspace=indent,eol,start
set encoding=latin1
set expandtab
set fileencodings=ucs-bom,utf-8,default,latin1
set fileformats=unix,mac,dos
set guitablabel=%M%t
set helplang=en
set hlsearch
set ignorecase
set incsearch
set langmenu=none
set laststatus=2
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set modelines=0
set nomore
set mouse=a
set printexpr=system('open\ -a\ Preview\ '.v:fname_in)\ +\ v:shell_error
set ruler
set runtimepath=~/.vim,~/.vim/bundle/mustache,~/.vim/bundle/nerdtree,~/.vim/bundle/rust.vim,~/.vim/bundle/syntastic,~/.vim/bundle/vim-airline,~/.vim/bundle/vim-classpath,~/.vim/bundle/vim-clojure-static,~/.vim/bundle/vim-coffee-script,~/.vim/bundle/vim-fireplace,~/.vim/bundle/vim-fugitive,~/.vim/bundle/vim-gocode,~/.vim/bundle/vim-handlebars,~/.vim/bundle/vim-markdown,~/.vim/bundle/vim-stylus,/usr/local/Cellar/macvim/7.4-72/MacVim.app/Contents/Resources/vim/vimfiles,/usr/local/Cellar/macvim/7.4-72/MacVim.app/Contents/Resources/vim/runtime,/usr/local/Cellar/macvim/7.4-72/MacVim.app/Contents/Resources/vim/vimfiles/after,~/.vim/bundle/rust.vim/after,~/.vim/bundle/vim-coffee-script/after,~/.vim/bundle/vim-markdown/after,~/.vim/after
set scrolloff=4
set shiftround
set shiftwidth=4
set showcmd
set smartcase
set smartindent
set smarttab
set noswapfile
set tabstop=4
set termencoding=utf-8
set title
set undodir=~/tmp/.VIM_UNDO_FILES
set undofile
set undolevels=5000
set updatecount=10
set viminfo=!,h,'50,<10000,s1000,/1000,:1000
set virtualedit=block
set visualbell
set wildignore=*.o,*.obj,*~,*vim/backups*,*sass-cache*,*DS_Store*,vendor/rails/**,vendor/cache/**,*.gem,log/**,tmp/**,*.png,*.jpg,*.gif
set wildmenu
set wildmode=list:longest,full
set window=56
" vim: set ft=vim :
