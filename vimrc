colorscheme darkblue

set nocompatible

if has('nvim')
    if empty(glob('~/.config/nvim/autoload/plug.vim'))
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall | source ~/.config/nvim/init.vim
    endif
else
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall | source ~/.vimrc
    endif
endif


"===============================================================================
" Plug
"===============================================================================

call plug#begin('~/.vim/plugged')

" A memoizing Parsing Expression Grammar parser generator for Vim.
" Plug 'https://github.com/dahu/Vimpeg.git'

Plug 'https://github.com/Shougo/vimproc', { 'do': 'make -f make_unix.mak' }

" UNITE
Plug 'https://github.com/Shougo/unite.vim'

" use this for Unite file_list
"
function! FindFileSearchUp(file_name)
    " From our current directory, search up for file list
    let l:file_name = findfile(a:file_name, '.;/')      " must be somewhere above us
    let l:file_name = fnamemodify(l:file_name, ':p')    " get the full path
    if filereadable(l:file_name)
        return l:file_name
    else
        return a:file_name
    endif
endfunction

Plug 'https://github.com/Shougo/unite-outline'
Plug 'https://github.com/Shougo/unite-help'
Plug 'https://github.com/Shougo/unite-session'
Plug 'https://github.com/Shougo/neomru.vim'
    let g:unite_source_mru_do_validate = 0
Plug 'https://github.com/Shougo/neoyank.vim.git'
Plug 'https://github.com/Shougo/tabpagebuffer.vim'
Plug 'https://github.com/thinca/vim-unite-history'
Plug 'https://github.com/hewes/unite-gtags.git'
Plug 'https://github.com/tex/vim-unite-id.git'
Plug 'https://github.com/kannokanno/unite-todo.git'
Plug 'https://github.com/kmnk/vim-unite-giti.git'
Plug 'https://github.com/tacroe/unite-mark.git'
    let g:unite_source_mark_marks =
                \   "abcdefghijklmnopqrstuvwxyz"
                \ . "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                \ . "0123456789.'`^<>[]{}()\""

Plug 'https://github.com/sanford1/unite-unicode.git'
Plug 'https://github.com/kopischke/unite-spell-suggest.git'
Plug 'https://github.com/osyo-manga/unite-quickfix.git'

" File manager
Plug 'https://github.com/Shougo/vimfiler.vim'
Plug 'https://github.com/romgrk/vimfiler-prompt.git'
    let g:loaded_netrwPlugin = 1 " Disable netrw.vim
    let g:vimfiler_safe_mode_by_default = 0
    let g:unite_kind_file_use_trashbox = 1
    let g:vimfiler_as_default_explorer = 1
    let g:vimfiler_split_rule="botright"
    let g:vimfiler_force_overwrite_statusline = 1
    let g:vimfiler_enable_auto_cd = 0
    let g:vimfiler_time_format = "%y/%m/%d %H:%M"

    nnoremap <silent> - :VimFilerBufferDir -buffer-name=vimfiler<CR>

    autocmd FileType vimfiler call s:vimfiler_settings()
    function! s:vimfiler_settings()
        set signcolumn=no
        nunmap <buffer> <C-i>
        nmap <buffer> i :VimFilerPrompt<CR>
    endfunction


" Code completion
    
" Requires vim8 with has('python') or has('python3')
" Requires the installation of msgpack-python. (pip install msgpack-python)
if !has('nvim')
    Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'https://github.com/roxma/nvim-completion-manager.git' " asynchronous completion
    set shortmess+=c
    let g:cm_matcher = {'module': 'cm_matchers.fuzzy_matcher', 'case': 'smartcase'}
    let g:cm_auto_popup = 1
    let g:cm_complete_start_delay = 1000
    inoremap <c-c> <ESC>
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    imap <c-g> <Plug>(cm_force_refresh)
Plug 'https://github.com/othree/csscomplete.vim'
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci
Plug 'fgrsnau/ncm-otherbuf'
Plug 'https://github.com/roxma/ncm-clang.git'
"Plug 'https://github.com/justmao945/vim-clang.git'
"let g:clang_compilation_database = '.'
"let g:clang_c_options = '-std=gnu11'
"let g:clang_cpp_options = '-std=c++14 -stdlib=libc++ -w -I./'

"Plug 'https://github.com/roxma/clang_complete.git'
"    let g:clang_library_path='/run/current-system/sw/lib'
"    au FileType c,cpp  nmap gd <Plug>(clang_complete_goto_declaration)
" Compiler options can be configured in a .clang_complete file in each project root. Example of .clang_complete file:
" -DDEBUG
" -include ../config.h
" -I../common
" -I/usr/include/c++/4.5.3/
" -I/usr/include/c++/4.5.3/x86_64-slackware-linux/
" 
"     Makefile example for auto-generating .clang_complete
" 
" .clang_complete: Makefile
" 	echo $(CXXFLAGS) > $@
" 
" If you are using cmake, unfortunately, I don't have a decent hack. This might work. Currently I use make VERBOSE=1
" to show the compile command and then edit the .clang_complete manually.    

Plug 'https://github.com/Shougo/neco-vim.git'
Plug 'https://github.com/jsfaint/gen_tags.vim.git' " nvim-completion-manager source
Plug 'https://github.com/Shougo/neoinclude.vim.git'

"Plug 'https://github.com/marijnh/tern_for_vim.git'        " JavaScript completion - Not programming in JavaScript
"Plug 'https://github.com/jimenezrick/vimerl.git'
"Plug 'https://github.com/osyo-manga/vim-snowdrop.git'
"Plug 'https://github.com/vim-erlang/vim-erlang-omnicomplete'
"Plug 'https://github.com/wting/rust.vim.git'                 " Not programming in rust currently
"Plug 'https://github.com/kchmck/vim-coffee-script'
"Plug 'https://github.com/xolox/vim-misc.git' " for lua

"Plug 'https://github.com/scrooloose/nerdcommenter' " Comments: \ci
"    " Always leave a space between the comment character and the comment
"    let NERDSpaceDelims=1
"
"    Plug 'https://github.com/neomake/neomake.git'
"    let g:neomake_cpp_enabled_makers = ['clang']
"    let g:neomake_cpp_clang_maker = {
"                \ 'args': ['-std=c++14', '-w', '-I./']
"                \ }
"    augroup vimrc_neomake
"        au!
"        autocmd BufWritePost * Neomake
"    augroup END
"  let g:neomake_verbose = 3

"    Plug 'https://github.com/scrooloose/syntastic' " Syntax checker
"    " Don't use Syntastic on erlang files, vimerl does better job
"    let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['erlang'] }


"Plug 'https://github.com/sbdchd/neoformat.git'
"augroup fmt
"  autocmd!
"  autocmd BufWritePre * undojoin | Neoformat
"augroup END


Plug 'https://github.com/w0rp/ale.git' " Neomake and Syntastic replacement
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_completion_enabled = 0
let g:ale_sign_column_always = 1
let g:ale_linters = {
\   'cpp': ['clang', 'clangcheck', 'clangtidy'],
\}
" This does same job as Neoformat
let g:ale_fixers = {                   
\   'cpp' : [ 'clang-format' ],
\}
let g:ale_fix_on_save = 1

" This depends on ncm-clang
autocmd BufEnter *.cpp,*.hpp let g:ale_cpp_clang_options = join(ncm_clang#compilation_info()['args'], ' ')
autocmd BufEnter *.c,*.h   let g:ale_c_clang_options = join(ncm_clang#compilation_info()['args'], ' ')

" This would be needed if my patch to ALE is not accepted.
" autocmd BufEnter *.cpp,*.h,*.hpp,*.hxx let g:ale_cpp_clang_options = join(ncm_clang#compilation_info()['args'], ' ')

" Bind F8 to fixing problems with ALE
"  nmap <F8> <Plug>(ale_fix)

" Text Objects
Plug 'https://github.com/wellle/targets.vim.git' " di', cin), da, ... many targets
Plug 'https://github.com/kana/vim-textobj-user' " create your own text objects without pain
Plug 'https://github.com/kana/vim-textobj-entire' " ae, ie
Plug 'https://github.com/kana/vim-textobj-lastpat' " a/, i/, a?, i?
Plug 'https://github.com/kana/vim-textobj-line' " al, il
Plug 'https://github.com/kana/vim-textobj-indent' " ai, ii, aI, iI
Plug 'https://github.com/gaving/vim-textobj-argument' " aa, ia
Plug 'https://github.com/terryma/vim-expand-region' " Shift +, Shift -
Plug 'https://github.com/kana/vim-operator-user.git'

" Not using it too much. Well, I don't remember last time I used it or needed it.
" Plug 'https://github.com/atweiden/vim-dragvisuals.git' " visual selection move
"     vmap  <expr>  D        DVB_Duplicate()

"     " Remove any introduced trailing white space after moving...
"     let g:DVB_TrimWS = 1

"     vmap  <expr>  <c-LEFT>   DVB_Drag('left')
"     vmap  <expr>  <c-RIGHT>  DVB_Drag('right')
"     vmap  <expr>  <c-DOWN>   DVB_Drag('down')
"     vmap  <expr>  <c-UP>     DVB_Drag('up')

" Not using it.
" Plug 'https://github.com/vim-scripts/IndentConsistencyCop' " Tabs vs Spaces, Smart-Tabs

Plug 'https://github.com/dyng/ctrlsf.vim.git' " grep with preview and edit

" Not using it.
" Plug 'https://github.com/Shougo/vinarise.git' " hex editing
"    let g:vinarise_enable_auto_detect = 1

Plug 'https://github.com/reedes/vim-wordy.git' " (also turns spell checking on all files)

" Not really using it.
" Plug 'https://github.com/justinmk/vim-sneak.git' " the missing motion for Vim: s{char}{char}

Plug 'https://github.com/airblade/vim-rooter.git' " changes working directory to project root
    " let g:rooter_change_directory_for_non_project_files = 1
    let g:rooter_manual_only = 1
    let g:rooter_silent_chdir = 1

Plug 'https://github.com/gcavallanti/vim-noscrollbar.git' " scrollbar

Plug 'https://github.com/junegunn/rainbow_parentheses.vim.git' " rainbow parentheses
    au Filetype * RainbowParentheses
    let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

"Interesting concept, but it colors only text, not whole line.
"Plug 'https://github.com/thiagoalessio/rainbow_levels.vim.git'
"    au Filetype * RainbowLevelsOn
"let g:rainbow_levels = [
"    \{'ctermbg': 232, 'guibg': '#080808'},
"    \{'ctermbg': 233, 'guibg': '#121212'},
"    \{'ctermbg': 234, 'guibg': '#1c1c1c'},
"    \{'ctermbg': 235, 'guibg': '#262626'},
"    \{'ctermbg': 236, 'guibg': '#303030'},
"    \{'ctermbg': 237, 'guibg': '#3a3a3a'},
"    \{'ctermbg': 238, 'guibg': '#444444'},
"    \{'ctermbg': 239, 'guibg': '#4e4e4e'},
"    \{'ctermbg': 240, 'guibg': '#585858'}]

Plug 'https://github.com/mechatroner/rainbow_csv.git'

Plug 'https://github.com/kshenoy/vim-signature.git' " toggle, display and navigate marks
Plug 'https://github.com/Tuxdude/mark.vim'

"Interesting concept, but buggy and slow.
"Plug 'https://github.com/chrisbra/DynamicSigns.git'

Plug 'https://github.com/chrisbra/NrrwRgn.git' " narrow region: \nr

Plug 'https://github.com/tommcdo/vim-kangaroo.git' " manual jump stack: zp, zP

"Plug 'https://github.com/pgdouyon/vim-evanesco.git' " replacement for vim-oblique - improved / search, mark.vim is better

Plug 'https://github.com/chrisbra/vim-diff-enhanced' " :EnhancedDiff ...
    " If started In Diff-Mode set diffexpr (plugin not loaded yet)
    if &diff
        let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
    endif

Plug 'https://github.com/tmhedberg/matchit.git' " Extended matching with '%'

Plug 'https://github.com/vim-scripts/ShowMultiBase.git' " Display number under cursor in specified format(s): \= \b= \o= \d= \h=
    let g:ShowMultiBase_Parse_Binary_PrefixPattern = '0\=[bB]'
    let g:ShowMultiBase_Display_Decimal_Show = 1

Plug 'https://github.com/vimwiki/vimwiki.git', { 'rev' : 'dev' } " vim wiki
    let g:vimwiki_listsyms = '✗○◐●✓'
    let g:vimwiki_list = [{'auto_tags': 1}]
    let g:vimwiki_table_mappings=0
    let g:vimwiki_table_auto_fmt=0

" Plug 'https://github.com/itchyny/calendar.vim' " calendar, cool but I'm not using it

" Plug 'https://github.com/powerman/vim-plugin-AnsiEsc.git' " ansi escape sequence visualization, cool, but enable it only when needed

" GIT integration

" Plug 'https://github.com/tpope/vim-fugitive'
" Plug 'https://github.com/gregsexton/gitv'
Plug 'https://github.com/airblade/vim-gitgutter.git'
    nnoremap <leader>gr :GitGutterRevertHunk<CR>
    let g:gitgutter_max_signs=99999999

Plug 'https://github.com/jreybert/vimagit.git'

" Pandoc - Markdown
Plug 'https://github.com/vim-pandoc/vim-pandoc'
    let g:pandoc#folding#mode = "stacked"
    let g:pandoc#folding#fold_fenced_codeblocks = 1

Plug 'https://github.com/vim-pandoc/vim-pandoc-syntax.git'
    let g:pandoc#syntax#codeblocks#embeds#langs = ["cpp", "dot", "python", "diff"]

Plug 'https://github.com/vim-pandoc/vim-pandoc-after.git'| " for Unite outline
    Plug 'https://github.com/Shougo/unite.vim'
    let g:pandoc#after#modules#enabled = ["unite"]

"Well, Konqueror is basically abandoned, not working well on NixOs,
"      Firefox is going south and deprecating Addons/Extensions and the
"      remote control extension I used is no longer supported with recent
"      Firefox versions.
"Plug 'https://github.com/tex/vimpreviewpandoc.git' |
"    Plug 'https://github.com/kmnk/vim-unite-giti.git' |
"    Plug 'https://github.com/Shougo/unite.vim'

Plug 'https://github.com/sheerun/vim-polyglot.git' " a collection of programming language packs for Vim

Plug 'https://github.com/mbbill/undotree.git' " for visualize undo tree
    nnoremap <C-u> :UndotreeToggle<CR>
    function! g:Undotree_CustomMap()
        nmap <buffer> <S-u> <plug>UndotreeRedo
    endfunc

Plug 'https://github.com/Lokaltog/vim-easymotion.git' " for easy motion
    let g:EasyMotion_do_mapping=0
    map <Leader><Leader>w <Plug>(easymotion-bd-w)


" Plug 'https://github.com/hkupty/iron.nvim.git' " REPL interact
Plug 'https://github.com/metakirby5/codi.vim.git' " REPL scratch pad
    let g:codi#rightalign=0

Plug 'https://github.com/machakann/vim-highlightedyank.git'

Plug 'https://github.com/tex/vim-dirdiff.git'
    " this plugin has bug in parsing non-C language diff output
    let g:DirDiffForceLang = "C"

Plug 'https://github.com/Shougo/context_filetype.vim.git'
Plug 'https://github.com/Shougo/echodoc.vim.git'
"   set cmdheight=2
    set noshowmode
    let g:echodoc_enable_at_startup = 1

Plug 'https://github.com/thinca/vim-qfreplace.git'

"Plug 'https://github.com/idanarye/vim-dutyl.git' " D language

"Plug 'https://github.com/baabelfish/nvim-nim.git' " NIM language

Plug 'https://github.com/dhruvasagar/vim-table-mode'

Plug 'https://github.com/rhysd/clever-f.vim.git'
    let g:clever_f_ignore_case = 1
    let g:clever_f_show_prompt = 1

"Plug 'https://github.com/ckarnell/history-traverse.git'
Plug 'https://github.com/tex/vim-bufsurf.git'

" Plug 'https://github.com/vim-scripts/Conque-GDB.git' " the only usable plugin for debugging with GDB
Plug 'https://github.com/mechatroner/minimal_gdb.git'

Plug 'https://github.com/drzel/vim-scroll-off-fraction.git'
    let g:scroll_off_fraction = 0.25

call plug#end()

    " let g:dutyl_stdImportPaths=['/nix/store/m1b6nmpb11mjhgw59h7az9ay88jcxmhw-dmd-2.070.2/include']
	" call dutyl#register#tool('dcd-client', '/home/milan/dev/dlang/DCD/bin/dcd-client')
	" call dutyl#register#tool('dcd-server', '/home/milan/dev/dlang/DCD/bin/dcd-server')

    " <F2>: Save session
    nnoremap <F2> :<C-u>UniteSessionSave

    call unite#custom#profile('default', 'context', {
                \   'prompt_direction': 'below',
                \   'marked_icon': '✓'
                \ })

"		" Start insert mode in unite-action buffer.
"		call unite#custom#profile('action', 'context', {
"		\   'start_insert' : 1
"		\ })
"
"		" Set "-no-quit" automatically in grep unite source.
"		call unite#custom#profile('source/grep', 'context', {
"		\   'no_quit' : 1
"		\ })
"
"		" Use start insert by default.
"		call unite#custom#profile('default', 'context', {
"		\   'start_insert' : 1
"		\ })

    " Map space to the prefix for Unite
    nnoremap [unite] <Nop>
    nmap <space> [unite]

    nnoremap <silent> [unite]<space> :<C-u>Unite -buffer-name=resume resume<CR>

    " Quick yank history and registers
    nnoremap <silent> "" :<C-u>Unite -buffer-name=register history/yank register<CR>

    " Quick buffer
    "  the buffer:- (- means show only file buffers)
    nnoremap <silent> [unite]b :<C-u>Unite -buffer-name=buffers buffer:-<CR>
    nnoremap <silent> [unite]B :execute 'Unite -buffer-name=buffers -input='.expand('%:t:r').' buffer:-'<CR>

    " Quick outline
    nnoremap <silent> <C-\> :<C-u>Unite -buffer-name=outline -vertical outline<CR>

    " Quick sessions (projects)
    nnoremap <silent> [unite]p :<C-u>Unite -buffer-name=sessions session<CR>

    " Quick sources
    nnoremap <silent> [unite]a :<C-u>Unite -buffer-name=sources source<CR>

    " Quickly switch lcd
    nnoremap <silent> [unite]d :UniteWithProjectDir -buffer-name=change-cwd -default-action=lcd neomru/directory<CR>

    " Quick file search
    nnoremap <silent> [unite]f :execute 'UniteWithBufferDir -start-insert -buffer-name=file_list -resume file_list:'. escape(FindFileSearchUp('filelist.txt'), ':') .''<CR>
"   nnoremap <silent> [unite]F :UniteResume files<CR>

    " Search files with the same base name as has the currently selected buffer
    nnoremap <silent> [unite]fr :execute 'UniteWithProjectDir -buffer-name=file_rec -resume -input='.expand('%:t:r').' file_rec'<CR>
    nnoremap <silent> [unite]fg :execute 'UniteWithProjectDir -buffer-name=file_gtags_path -resume -input='.expand('%:t:r').' gtags/path'<CR>

    " Quick grep from cwd
    nnoremap <silent> [unite]g :Unite -buffer-name=grep grep<CR>
    nnoremap <silent> [unite]G :UniteResume grep<CR>

    " Quick help
    nnoremap <silent> [unite]h :Unite -buffer-name=help help<CR>

    " Quick line using the word under cursor
    nnoremap <silent> <C-_> :UniteWithCursorWord -buffer-name=search_file line<CR>

    " Quick MRU search
    nnoremap <silent> [unite]m :Unite -buffer-name=mru file_mru<CR>

    " Quick marks list
    nnoremap <silent> [unite]M :Unite -buffer-name=marks mark<CR>

    " Bufsurf
    nnoremap <silent> [unite]n :Unite -buffer-name=bufsurf bufsurf<CR>

    " Quick commands
    nnoremap <silent> [unite]c :Unite -buffer-name=commands command<CR>

    " Jump list
    nnoremap <silent> [unite]j :Unite -buffer-name=jumps jump<CR>

    " Quick commands
    nnoremap <silent> [unite]; :Unite -buffer-name=history history/command command<CR>

    " Spell suggest
    nnoremap <silent> z= :Unite -buffer-name=spell_suggest -vertical -winwidth=20 spell_suggest<CR>

    " Quick gtags references
    autocmd FileType c,cpp,yacc,java,php,asm,erlang,python nnoremap <silent> g[ :Unite -buffer-name=gtags-ref gtags/ref<CR>

    " Quick gtags definitions
    autocmd FileType c,cpp,yacc,java,php,asm,erlang,python nnoremap <silent> g] :Unite -buffer-name=gtags-def gtags/def<CR>

    nnoremap <silent> [unite]t :Unite -buffer-name=todo todo<CR>

    " Custom Unite settings
    autocmd FileType unite call s:unite_settings()

    function! s:unite_settings()
        imap <buffer> <C-w> <Plug>(unite_delete_backward_word)
        imap <buffer> <C-u> <Plug>(unite_delete_backward_path)
        imap <buffer> '     <Plug>(unite_quick_match_default_action)
        nmap <buffer> '     <Plug>(unite_quick_match_default_action)
        inoremap <silent><buffer><expr> <C-s> unite#do_action('split')
        nnoremap <silent><buffer><expr> <C-s> unite#do_action('split')
        inoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
        nnoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
        inoremap <silent><buffer><expr> <C-p> unite#do_action('preview')
        nnoremap <silent><buffer><expr> <C-p> unite#do_action('preview')
        inoremap <silent><buffer><expr> <C-o> unite#do_action('switch')
        nnoremap <silent><buffer><expr> <C-o> unite#do_action('switch')

        let unite = unite#get_current_unite()
        if unite.buffer_name =~# '^search'
            nnoremap <silent><buffer><expr> r     unite#do_action('replace')
        else
            nnoremap <silent><buffer><expr> r     unite#do_action('rename')
        endif

        nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')

        " Using Ctrl-\ to trigger outline, so close it using the same keystroke
        if unite.buffer_name =~# '^outline'
            imap <buffer> <C-\> <Plug>(unite_exit)
            nmap <buffer> <C-\> <Plug>(unite_exit)
        endif

        " Using z= to trigger spell_suggest, so close it using the same keystroke
        if unite.buffer_name =~# '^spell_suggest'
            imap <buffer> z= <Plug>(unite_exit)
            nmap <buffer> z= <Plug>(unite_exit)
        endif

        " Using Ctrl-/ to trigger line, close it using same keystroke
        if unite.buffer_name =~# '^search_file'
            imap <buffer> <C-_> <Plug>(unite_exit)
            nmap <buffer> <C-_> <Plug>(unite_exit)
        endif

        if unite.buffer_name =~# '^file_list'
            imap <buffer> <C-r> <esc>:silent exec '!find . -not \( -name .git -prune -o -name "*.o" -prune \) -type f -print > filelist.txt'<cr>
                        \ :silent exec '!sort filelist.txt -o filelist.txt'<cr><C-l>
            nmap <buffer> <C-r> :silent exec '!find . -not \( -name .git -prune -o -name "*.o" -prune \) -type f -print > filelist.txt'<cr>
                        \ :silent exec '!sort filelist.txt -o filelist.txt'<cr><C-l>
        endif

    endfunction

    " Enable short source name in window
    let g:unite_enable_short_source_names = 1

    " Enable history yank source
    let g:unite_source_history_yank_enable = 1

    " Open in bottom right
    let g:unite_split_rule = "botright"

    let g:unite_source_file_mru_limit = 1000
    let g:unite_cursor_line_highlight = 'TabLineSel'
    let g:unite_abbr_highlight = 'Normal'

    let g:unite_source_file_mru_filename_format = ':~:.'
    let g:unite_source_file_mru_time_format = ''

    " speed up recursive file searches and ignore patters in .gitignore
"    if executable('ag')
"        let g:unite_source_rec_async_command = [ 'ag', '--follow', '--nogroup', '--hidden', '--nocolor', '-g', '' ]
"        let g:unite_source_grep_command = 'ag'
"        let g:unite_source_grep_default_opts =
"                    \ '-i --vimgrep --hidden --ignore ' .
"                    \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
"        let g:unite_source_grep_recursive_opt = ''
"    endif

    call unite#custom_default_action('directory,directory_mru', 'cd')

    " Using unite-todo plugin, change notes format to 'markdown' (actually 'pandoc', since I have pandoc plugins installed):

    let g:unite_todo_note_suffix = 'markdown'

    " To be able to select firs line next to input in input mode
    let g:unite_enable_auto_select = 0

    "===============================================================================
    " Unite Sessions
    "===============================================================================

    " Save session automatically.
    let g:unite_source_session_enable_auto_save = 1

    " Pop up session selection if no file is specified
    "autocmd MyAutoCmd VimEnter * call s:unite_session_on_enter()
    "function! s:unite_session_on_enter()
    "    if !argc() && !exists("g:start_session_from_cmdline")
    "        Unite -buffer-name=sessions session
    "    endif
    "endfunction


    function! s:is_graph_only_line(candidate)
        return has_key(a:candidate.action__data, 'hash') ? 0 : 1
    endfunction

    let s:pandoc_diff_action = {
        \ 'description' : 'pandoc diff with vimpreviewpandoc',
        \ 'is_selectable' : 1,
        \ 'is_quit' : 1,
        \ 'is_invalidate_cache' : 0,
        \ }
    function! s:pandoc_diff_action.func(candidates)
        if s:is_graph_only_line(a:candidates[0])
                    \ || len(a:candidates) > 1 && s:is_graph_only_line(a:candidates[1])
            call giti#print('graph only line')
            return
        endif

        let from  = ''
        let to    = ''
        let file  = len(a:candidates[0].action__file) > 0
                    \               ? a:candidates[0].action__file
                    \               : expand('%:p')
        let relative_path = giti#to_relative_path(file)
        if len(a:candidates) == 1
            let to   = a:candidates[0].action__data.hash
            let from = a:candidates[0].action__data.parent_hash
        elseif len(a:candidates) == 2
            let to   = a:candidates[0].action__data.hash
            let from = a:candidates[1].action__data.hash
        else
            call unite#print_error('too many commits selected')
            return
        endif

        call vimpreviewpandoc#VimPreviewPandocGitDiff(relative_path, from, to)
    endfunction

    call unite#custom#action('giti/log', 'diff_pandoc_preview', s:pandoc_diff_action)
    unlet s:pandoc_diff_action


filetype plugin indent on
syntax enable

"===============================================================================
" General Settings
"===============================================================================

" Turn on line number
set number

" Sets how many lines of history vim has to remember
set history=10000

" Set to auto read when a file is changed from the outside
set autoread

" listchar=trail is not as flexible, use the below to highlight trailing
" whitespace. Don't do it for unite windows or readonly files
"highlight ExtraWhitespace ctermbg=grey guibg=grey
"match ExtraWhitespace /\s\+$/
"augroup MyAutoCmd
"  autocmd BufWinEnter * if &modifiable && &ft!='unite' | match ExtraWhitespace /\s\+$/ | endif
"  autocmd InsertEnter * if &modifiable && &ft!='unite' | match ExtraWhitespace /\s\+\%#\@<!$/ | endif
"  autocmd InsertLeave * if &modifiable && &ft!='unite' | match ExtraWhitespace /\s\+$/ | endif
"  autocmd BufWinLeave * if &modifiable && &ft!='unite' | call clearmatches() | endif
"augroup END

" Min width of the number column to the left
" set numberwidth=1

" Auto complete setting
set completeopt=longest,menuone

set wildmode=list:longest,full
set wildmenu "turn on wild menu
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

" Allow changing buffer without saving it first
set hidden
set confirm

" Case insensitive search
set ignorecase
set smartcase

" Set sensible heights for splits
"set winheight=40
" Setting this causes problems with Unite-outline. Don't really need it
"set winminheight=3

" Make search act like search in modern browsers
set incsearch

" Highlight all search matches
set hlsearch

" Make regex a little easier to type
set magic

" Don't show matching brackets
set noshowmatch

" Show incomplete commands
set showcmd

" Turn off sound
set vb
set t_vb=

" Always show the status line
set laststatus=2

" Explicitly set encoding to utf-8
set encoding=utf-8

" Column width indicator
" set colorcolumn=+1

" For faster InsertLeave triggering
set ttimeoutlen=50

" Turn backup off
set nobackup
set nowritebackup
set noswapfile

" Tab settings
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab

" Text display settings
set linebreak
" set textwidth=80
set nowrap
set whichwrap+=h,l,<,>,[,]

" Writes to the unnamed register also writes to the * and + registers. This
" makes it easy to interact with the system clipboard
if has ('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif

" Use a low updatetime. This is used by CursorHold
" set updatetime=1000

" Set autochdir, works better with Unite.vim
" set autochdir

" Autosave & Load Views.
set viewoptions=folds,cursor
autocmd BufWritePost,BufLeave,WinLeave,BufWinLeave * if &modifiable && &ft!='unite' | silent! mkview | endif
autocmd BufWinEnter * if &modifiable && &ft!='unite' | silent! loadview | endif

" Spell-checking
" Add words to the dictionary by cursoring over those words in a file and
" typing: zg
autocmd FileType pandoc set complete+=kspell
autocmd FileType pandoc setlocal spell
set spell

" Search for tags file in upper directories until tags file found.
set tags=./tags;/

" Persistent undo
set undodir=~/.vim.undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

"===============================================================================
" Function Key Mappings
"===============================================================================

"===============================================================================
" Leader Key Mappings
"===============================================================================


"===============================================================================
" Command-line Mode Key Mappings
"===============================================================================

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee %

" Allow to change permission before write.
cmap w!!! silent w !chmod +w %

"===============================================================================
" Normal Mode Shift Key Mappings
"===============================================================================


"===============================================================================
" Normal Mode Ctrl Key Mappings
"===============================================================================

map <C-Up>   <C-y>
map <C-Down> <C-e>

" u - undo, S-u redo, C-u gundo
map <S-u> :redo<CR>

"===============================================================================
" Insert Mode Ctrl Key Mappings
"===============================================================================
inoremap <C-Up> <Esc><C-y><Insert><Right>
inoremap <C-Down> <Esc><C-e><Insert><Right>

"===============================================================================
" Visual Mode Ctrl Key Mappings
"===============================================================================


"===============================================================================
" Normal Mode Meta Key Mappings
"===============================================================================


"===============================================================================
" Insert Mode Meta Key Mappings
"===============================================================================


"===============================================================================
" Visual Mode Meta Key Mappings
"===============================================================================


"===============================================================================
" Space Key Mappings
"===============================================================================

"===============================================================================
" Normal Mode Key Mappings
"===============================================================================

" Tab: Go to matching element
" Disabled for now because <Tab> is equal to <C-i> which I use heavily
" nnoremap <Tab> %

nnoremap cd :lcd %:p:h<bar>pwd<cr>

" Let PgUp and PgDown scroll up to first/last line.
nnoremap <pageup> <c-u><c-u>
nnoremap <pagedown> <c-d><c-d>

nnoremap <A-Up> <C-w>k
nnoremap <A-Down> <C-w>j
nnoremap <A-Left> <C-w>h
nnoremap <A-Right> <C-w>l

nnoremap <leader>1 1<C-w>w
nnoremap <leader>2 2<C-w>w
nnoremap <leader>3 3<C-w>w
nnoremap <leader>4 4<C-w>w
nnoremap <leader>5 5<C-w>w
nnoremap <leader>6 6<C-w>w
nnoremap <leader>7 7<C-w>w

"===============================================================================
" Visual Mode Key Mappings
"===============================================================================

" vmap - mapping for visual mode
" _d - delete current selection into "black hole register"
" P - paste
vmap r "_dP

"===============================================================================
" Operator Pending Mode Key Mappings
"===============================================================================

" Replace a word under cursor by pressing \s
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

"===============================================================================
" Autocommands
"===============================================================================

" The most accurate syntax highlighting.
autocmd BufEnter * :syntax sync fromstart

" Enable omni completion
"augroup MyAutoCmd
"  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
"  autocmd FileType java setlocal omnifunc=eclim#java#complete#CodeComplete
"augroup END

" Show marks columns even when there are no signs shown.
autocmd BufEnter * sign define dummy
autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')



" >>   Indent line by shiftwidth spaces
" <<   De-indent line by shiftwidth spaces
" 5>>  Indent 5 lines
" 5==  Re-indent 5 lines
"
" >%   Increase indent of a braced or bracketed block (place cursor on brace first)
" =%   Reindent a braced or bracketed block (cursor on brace)
" <%   Decrease indent of a braced or bracketed block (cursor on brace)
" ]p   Paste text, aligning indentation with surroundings
"
" =i{  Re-indent the 'inner block', i.e. the contents of the block
" =a{  Re-indent 'a block', i.e. block and containing braces
" =2a{ Re-indent '2 blocks', i.e. this block and containing block
"
" >i{  Increase inner block indent
" <i{  Decrease inner block indent
" You can replace { with } or B, e.g. =iB is a valid block indent command. Take a look at 'Indent a Code Block' for a nice example to try these commands out on.
"
" Also, remember that
"
" .    Repeat last command

" >>> Play Python from within Vim
" >>> useful to copy/paste samples and run inside Vim
" >>> [usage] Normal_<C-L> against a Python block
" >>>         Visual_<C-L> on Visual Python block
" >>>         Insert_<C-L>, automatically add print()
" ================================
if has('python') || has('python3')
" ================================
nn<silent>Zy :let pyf=tempname()<CR>
   \:sil!let python=has('python3')?'py3file ':'pyfile '<CR>
   \:sil!let yank = substitute(@0,'[>.]\{3}\s\=','','g')<CR>
   \:sil!let eval = 'print('.yank.')'<CR>
   \:sil!call writefile(split(eval,'\n'),pyf)<CR>
   \:sil!redir @"<Bar>sil!exe 'silent!'.python.pyf<CR>:redir END<CR>
   \:sil!let @"=substitute(strtrans(@"),'\^@','','g')<CR>
   \A = <Esc>""pA
nn<silent>Zz :let pyf=tempname()<CR>
   \:sil!let python=has('python3')?'py3file ':'pyfile '<CR>
   \:sil!let yank = substitute(@0,'[>.]\{3}\s\=','','g')<CR>
   \:sil!call writefile(split(yank,'\n'),pyf)<CR>
   \:sil!redir @"<Bar>sil!exe 'silent!'.python.pyf<CR>:redir END<CR>
   \:sil!let @"=substitute(strtrans(@"),'\^@','','g')<CR>
   \A<CR><Esc>""pA<CR><Esc>
nm<silent> <C-L>   yip}Zz
xm<silent> <C-L> :y<CR>}Zz
im<silent> <C-L> <Esc>:y<CR>Zy
" --------------------------------------------
endif

" TODO >>> Play Erlang from within Vim
" erl -noshell -eval 'R = 16#1F+16#A0, io:format("~.16B~n", [R])' -s erlang halt

set foldmethod=indent
set foldenable

set breakindent

" Better new line indentation for C, CPP files.
au FileType c,cpp :set cinoptions+=L0

" I like the darkblue colorscheme but don't like its LineNr being green.
" Prefer non-obtrusive darkgrey.
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

highlight SpellBad ctermfg=202 ctermbg=NONE cterm=NONE
highlight SpellCap ctermfg=202 ctermbg=NONE cterm=NONE
highlight SpellRare ctermfg=202 ctermbg=NONE cterm=NONE
highlight SpellLocal ctermfg=202 ctermbg=NONE cterm=NONE

" Default is some unreadable light-blue:
"  term=standout ctermfg=15 ctermbg=81 guifg=#ffffff guibg=#287ef
highlight ErrorMsg term=reverse ctermfg=15 ctermbg=9 guifg=White guibg=Red

" Default is some unreadable ping with light text:
"
highlight DiffChange ctermfg=9 ctermbg=NONE cterm=NONE
highlight DiffText   ctermfg=9 ctermbg=NONE cterm=NONE

" I don't know what plugin sets the SignColumn to ctermbg=242
" which I hate since it also messes up the vim-gitgutter.
highlight clear SignColumn

" Default is unreadable
highlight Visual ctermfg=81 ctermbg=21
highlight MatchParn ctermfg=2 ctermbg=NONE cterm=NONE
highlight CursorLine cterm=bold ctermfg=black ctermbg=lightblue

set ffs=unix,dos,mac

" Disable showing of: Hit enter or type command to command to continue
set sc nosc

set linebreak
set showbreak=↪

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline ctermbg=lightblue ctermfg=black
"   set cursorcolumn
  elseif a:mode == 'r'
    hi statusline ctermbg=red ctermfg=black
  else
    hi statusline ctermbg=green ctermfg=black
  endif
endfunction

function! InsertLeaveActions()
  hi statusline ctermbg=green ctermfg=black
" set nocursorcolumn
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertChange * call InsertStatuslineColor(v:insertmode)
au InsertLeave * call InsertLeaveActions()
call InsertLeaveActions()

" to handle exiting insert mode via a control-C
inoremap <c-c> <c-o>:call InsertLeaveActions()<cr><c-c>

if has('nvim')
  set icm=nosplit
  set mouse=a
endif

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

function! HistoryStatus() abort
    if exists("w:history_index") && exists("w:history")
        return printf('%s %s',
                    \ w:history_index != 0 ? '←' : ' ',
                    \ w:history_index < (len(w:history) - 1) ? '→' : ' ')
    else
        return '   '
    endif
endfunction

set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %{LinterStatus()}\ %{HistoryStatus()}\ %{noscrollbar#statusline(9,'■','◫',['◧'],['◨'])}

nnoremap <c-n> :BufSurfBack<cr>
nnoremap <c-m> :BufSurfForward<cr>
let g:BufSurfIgnore = "vimfiler"
let g:BufSurfAppearOnce = 0

set signcolumn=yes



