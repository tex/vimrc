colorscheme darkblue

set nocompatible

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source ~/.vimrc
endif


"===============================================================================
" Plug
"===============================================================================

call plug#begin('~/.vim/plugged')

Plug 'https://github.com/dahu/Vimpeg.git'

Plug 'https://github.com/Shougo/vimproc', { 'do': 'make -f make_unix.mak' }

" UNITE
Plug 'https://github.com/Shougo/unite.vim'

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
    let g:loaded_netrwPlugin = 1 " Disable netrw.vim
    let g:vimfiler_safe_mode_by_default = 0
    let g:unite_kind_file_use_trashbox = 1
    let g:vimfiler_as_default_explorer = 1
    let g:vimfiler_split_rule="botright"
    let g:vimfiler_force_overwrite_statusline = 0
    let g:vimfiler_enable_auto_cd = 0
    let g:vimfiler_time_format = "%y/%m/%d %H:%M "  " The space at the end is important (my terminal cuts off last column?...)

    nnoremap <silent> - :VimFilerBufferDir -create<CR>

    autocmd FileType vimfiler call s:vimfiler_settings()
    function! s:vimfiler_settings()
        nunmap <buffer> <C-i>
    endfunction

" Code completion
let use_deoplete = 1

if has('nvim') && use_deoplete
    Plug 'https://github.com/Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
        let g:deoplete#enable_at_startup = 1

    " Plug 'https://github.com/carlitux/deoplete-ternjs'        " Javascript completion - Not programming in Javascript
    Plug 'https://github.com/zchee/deoplete-jedi'             " Python completion
    Plug 'https://github.com/zchee/deoplete-clang'            " C/C++ completion
        " libclang shared library path
        let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'

        " clang builtin header path
        let g:deoplete#sources#clang#clang_header = '/usr/lib/clang/3.8.1/include'

        " C or C++ standard version
        let g:deoplete#sources#clang#std#c = 'c11'
        " or c++
        let g:deoplete#sources#clang#std#cpp = 'c++1z'

        " alphabetical sort order
        let g:deoplete#sources#clang#sort_algo = 'alphabetical'

        " compile_commands.json directory path
        let g:deoplete#sources#clang#clang_complete_database = '~/.cache/deoplete-clang/build/'

        " default flags
        let g:deoplete#sources#clang#flags = [ "-cc1", "-triple x86_64-unknown-linux-gnu", "-E", "-disable-free", "-disable-llvm-verifier", "-main-file-name", "-mrelocation-model static", "-mthread-model posix", "-mdisable-fp-elim", "-fmath-errno", "-masm-verbose", "-mconstructor-aliases", "-munwind-tables", "-fuse-init-array", "-target-cpu x86-64", "-v", "-dwarf-column-info", "-debugger-tuning=gdb", "-resource-dir /usr/bin/../lib/clang/3.8.1", "-internal-isystem /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/6.2.1/../../../../include/c++/6.2.1", "-internal-isystem /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/6.2.1/../../../../include/c++/6.2.1/x86_64-pc-linux-gnu", "-internal-isystem /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/6.2.1/../../../../include/c++/6.2.1/backward", "-internal-isystem /usr/local/include", "-internal-isystem /usr/bin/../lib/clang/3.8.1/include", "-internal-externc-isystem /include", "-internal-externc-isystem /usr/include", "-fdeprecated-macro", "-fdebug-compilation-dir ~/.cache/deoplete/build/", "-ferror-limit 19", "-fmessage-length 176", "-fobjc-runtime=gcc", "-fcxx-exceptions", "-fexceptions", "-fdiagnostics-show-option", "-fcolor-diagnostics", "-o", "-", "-x c++" ]
else
    let use_completor = 1
    if use_completor
    Plug 'maralla/completor.vim'
    else
    Plug 'https://github.com/Valloric/YouCompleteMe', { 'do': 'python2 install.py --clang-completer' } " C/C++ completion
        let g:ycm_confirm_extra_conf = 0
        let g:ycm_server_keep_logfiles = 1
        let g:ycm_server_log_level = 'critical'

        " Map <leader>jd to YcmCompleter's goto definition or declaration
        nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>

        let g:ycm_filetype_specific_completion_to_disable = {'unite' : 1}

        let g:ycm_autoclose_preview_window_after_completion = 1
        let g:ycm_autoclose_preview_window_after_insertion = 1

        " YCM removes all signs in the buffer when updating its signs.
        " Disabling YCM's signs since highlighting itself is good enough.
        let g:ycm_enable_diagnostic_signs = 0

        " Workaround the YCM bug. YCM should use erlang semantic completion engine,
        " but it uses it only from the begining of typing, then it switches to a garbage.
        " https://github.com/Valloric/YouCompleteMe/issues/3
        "let g:ycm_filetype_blacklist = {'erlang' : 1}

        let g:ycm_concealing_delimiters = ['⟪', '⟫']

        let g:ycm_semantic_triggers =  {
                    \   'c' : ['->', '.'],
                    \   'objc' : ['->', '.'],
                    \   'ocaml' : ['.', '#'],
                    \   'cpp,objcpp' : ['->', '.', '::'],
                    \   'perl' : ['->'],
                    \   'php' : ['->', '::'],
                    \   'cs,java,javascript,d,vim,python,perl6,scala,vb,elixir,go' : ['.'],
                    \   'ruby' : ['.', '::'],
                    \   'lua' : ['.', ':'],
                    \   'erlang' : [':'],
                    \ }

        let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

    Plug 'https://github.com/davidhalter/jedi-vim.git'        " Python completion
    " Plug 'https://github.com/marijnh/tern_for_vim.git'        " JavaScript completion - Not programming in JavaScript
    endif
endif
"Plug 'https://github.com/Rip-Rip/clang_complete.git'
"Plug 'https://github.com/jimenezrick/vimerl.git'
"Plug 'https://github.com/osyo-manga/vim-snowdrop.git'
"Plug 'https://github.com/vim-erlang/vim-erlang-omnicomplete'
"Plug 'https://github.com/wting/rust.vim.git'                 " Not programming in rust currently
"Plug 'https://github.com/kchmck/vim-coffee-script'
"Plug 'https://github.com/xolox/vim-misc.git' " for lua

Plug 'https://github.com/scrooloose/nerdcommenter' " Comments: \ci
    " Always leave a space between the comment character and the comment
    let NERDSpaceDelims=1

let use_neomake = 1

if has('nvim') && use_neomake
    Plug 'https://github.com/neomake/neomake.git'
    let g:neomake_cpp_enabled_makers = ['clang']
    let g:neomake_cpp_clang_maker = {
                \ 'args': ['-std=c++14']
                \ }
    augroup vimrc_neomake
        au!
        autocmd BufWritePost * Neomake
    augroup END
"   let g:neomake_verbose = 3
else
    Plug 'https://github.com/scrooloose/syntastic' " Syntax checker
    " Don't use Syntastic on erlang files, vimerl does better job
    let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['erlang'] }
endif

Plug 'https://github.com/Shougo/denite.nvim.git'    " fast file_rec

" Text Objects
Plug 'https://github.com/wellle/targets.vim.git' " di', cin), da, ... many targets
Plug 'https://github.com/kana/vim-textobj-user' " create your own text objects without pain
Plug 'https://github.com/kana/vim-textobj-entire' " ae, ie
Plug 'https://github.com/kana/vim-textobj-lastpat' " a/, i/, a?, i?
Plug 'https://github.com/kana/vim-textobj-line' " al, il
Plug 'https://github.com/kana/vim-textobj-indent' " ai, ii, aI, iI
Plug 'https://github.com/gaving/vim-textobj-argument' " aa, ia
Plug 'https://github.com/terryma/vim-expand-region' " Shift +, Shift -

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
    set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %{noscrollbar#statusline(9,'■','◫',['◧'],['◨'])}

Plug 'https://github.com/junegunn/rainbow_parentheses.vim.git' " rainbow parentheses
    au Syntax * RainbowParentheses
    let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

Plug 'https://github.com/kshenoy/vim-signature.git' " toggle, display and navigate marks

Plug 'https://github.com/chrisbra/NrrwRgn.git' " narrow region: \nr

Plug 'https://github.com/tommcdo/vim-kangaroo.git' " manual jump stack: zp, zP

Plug 'https://github.com/pgdouyon/vim-evanesco.git' " replacement for vim-oblique - improved / search

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

" Plug 'https://github.com/Konfekt/FastFold.git' " should speed up vim when folds are different from manual

" Plug 'https://github.com/itchyny/calendar.vim' " calendar, cool but I'm not using it

" Plug 'https://github.com/powerman/vim-plugin-AnsiEsc.git' " ansi escape sequence visualization, cool, but enable it only when needed

" GIT integration

" Plug 'https://github.com/tpope/vim-fugitive'
" Plug 'https://github.com/gregsexton/gitv'
Plug 'https://github.com/airblade/vim-gitgutter.git'
    nnoremap <leader>gr :GitGutterRevertHunk<CR>
    let g:gitgutter_max_signs=99999999

Plug 'https://github.com/jreybert/vimagit.git'

" Plug 'https://github.com/vim-scripts/Conque-GDB.git' " the only usable plugin for debugging with GDB

" Pandoc - Markdown
Plug 'https://github.com/vim-pandoc/vim-pandoc'
    let g:pandoc#folding#mode = "stacked"
    let g:pandoc#folding#fold_fenced_codeblocks = 1

Plug 'https://github.com/vim-pandoc/vim-pandoc-syntax.git'
    let g:pandoc#syntax#codeblocks#embeds#langs = ["cpp", "dot", "python", "diff"]

Plug 'https://github.com/vim-pandoc/vim-pandoc-after.git'| " for Unite outline
    Plug 'https://github.com/Shougo/unite.vim'
    let g:pandoc#after#modules#enabled = ["unite"]

Plug 'https://github.com/tex/vimpreviewpandoc.git' |
    Plug 'https://github.com/kmnk/vim-unite-giti.git' |
    Plug 'https://github.com/Shougo/unite.vim'

Plug 'https://github.com/sheerun/vim-polyglot.git' " a collection of programming language packs for Vim

Plug 'https://github.com/mbbill/undotree.git' " for visualize undo tree
    nnoremap <C-u> :UndotreeToggle<CR>
    function g:Undotree_CustomMap()
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

Plug 'https://github.com/Shougo/echodoc.vim.git'
	set noshowmode
	let g:echodoc_enable_at_startup = 1

call plug#end()

if has('nvim') && use_deoplete
    " deoplete needs to call this after plug#end()
    silent call deoplete#custom#set('_', 'matchers', ['matcher_full_fuzzy'])
endif

    " <F2>: Save session
    nnoremap <F2> :<C-u>UniteSessionSave

    call unite#custom#profile('default', 'context', {
                \   'prompt_direction': 'top',
                \   'marked_icon': '✓'
                \ })

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
    nnoremap <silent> [unite]f :UniteWithProjectDir -buffer-name=files -start-insert -resume file_rec<CR>
    nnoremap <silent> [unite]F :UniteResume files<CR>

    " Search files with the same base name as has the currently selected buffer
    nnoremap <silent> [unite]ff :execute 'UniteWithProjectDir -buffer-name=files -resume -input='.expand('%:t:r').' file_rec'<CR>
    nnoremap <silent> [unite]fg :execute 'UniteWithProjectDir -buffer-name=files -resume -input='.expand('%:t:r').' gtags/path'<CR>

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

    " Quick find
    nnoremap <silent> [unite]n :UniteWithProjectDir -buffer-name=find find:.<CR>

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
    if executable('ag')
        let g:unite_source_rec_async_command = [ 'ag', '--follow', '--nogroup', '--hidden', '--nocolor', '-g', '' ]
        let g:unite_source_grep_command = 'ag'
        let g:unite_source_grep_default_opts =
                    \ '-i --vimgrep --hidden --ignore ' .
                    \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
        let g:unite_source_grep_recursive_opt = ''
    endif

    call unite#custom_default_action('directory,directory_mru', 'cd')

    " Using unite-todo plugin, change notes format to 'markdown' (actually 'pandoc', since I have pandoc plugins installed):

    let g:unite_todo_note_suffix = 'markdown'

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

" Minimal number of screen lines to keep above and below the cursor
set scrolloff=5

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
set autoindent
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

" Let PgUp and PgDown scroll up to first/last line.
nnoremap <pageup> <c-u><c-u>
nnoremap <pagedown> <c-d><c-d>

nnoremap cd :lcd %:p:h<bar>pwd<cr>

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
augroup MyAutoCmd
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
  autocmd FileType java setlocal omnifunc=eclim#java#complete#CodeComplete
augroup END

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

"setl foldmethod=indent foldnestmax=2 foldlevelstart=99

set breakindent

" I like the darkblue colorscheme but don't like its LineNr being green.
" Prefer non-obtrusive darkgrey.
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

highlight SpellBad ctermfg=202 ctermbg=NONE cterm=NONE

" Default is some unreadable light-blue:
"  term=standout ctermfg=15 ctermbg=81 guifg=#ffffff guibg=#287ef
highlight ErrorMsg term=reverse ctermfg=15 ctermbg=9 guifg=White guibg=Red

" Default is some unreadable ping with light text:
"
highlight DiffChange ctermfg=9 ctermbg=NONE cterm=NONE
highlight DiffText   ctermfg=9 ctermbg=NONE cterm=NONE

" I don't know what plugin sets the SignColumn to ctermbg=242
" which I hate since it also messes up the vim-gitgutter.
highligh clear SignColumn

" Default is unreadable
highlight Visual ctermfg=81 ctermbg=21
highlight MatchParn ctermfg=2 ctermbg=NONE cterm=NONE

set ffs=unix,dos,mac

" Disable showing of: Hit enter or type command to command to continue
set sc nosc

set linebreak
set breakindent
set showbreak=↪
