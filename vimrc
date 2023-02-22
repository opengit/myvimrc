"""快捷键笔记


" G     ->  文件最后一行
" gg    ->  文件最前一行
" 123G  ->  文件第123行
" C_g   ->  文件总行数
" $     ->  当前行最后
" ^     ->  当前行最前
" %     ->  当前代码块开始/结尾
" x     ->  删除当前字符
" yw    ->  复制当前单词
" y$    ->  从当前位置复制到行尾
" y0    ->  从当前位置复制到行首
" y^    ->  从当前位置复制到第一个非空白字符
"
""""""""""""" 快捷键 """""""""""""""""
" <leader><F3>   ->    coc explorer
" <leader><F4>   ->    coc outline
" <leader><F5>   ->     diagnostics
" <leader><F6>   ->    fzf files
" <leader><F7>   ->    Rg full text search



" [[  Jump to previous class or function (normal, visual, operator modes)
" ]]  Jump to next class or function (normal, visual, operator modes)
" [M  Jump to previous class or method (normal, visual, operator modes)
" ]M  Jump to next class or method (normal, visual, operator modes)
" aC  Select a class. Ex: vaC, daC, yaC, caC (normal, operator modes)
" iC  Select inner class. Ex: viC, diC, yiC, ciC (normal, operator modes)
" aM  Select a function or method. Ex: vaM, daM, yaM, caM (normal, operator modes)
" iM  Select inner function or method. Ex: viM, diM, yiM, ciM (normal, operator modes)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""" 配置开始 """"""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""" 定义leader键
let mapleader=","
"""

""" F1 键换为其他
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>
nmap <leader><F1> :help<CR>
"""

""" 进入当前文件所在文件夹
nmap <leader>cd :lcd %:p:h<CR>
" autocmd BufEnter * silent! lcd %:p:h
"""


"""vim-plug
" Automatic installation of vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

""""""""" --->开始<---存放安装的插件及配置 """""""""
call plug#begin('~/.vim/plugins')

""" theme
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
"""

""" coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" 使用TAB键在候选中移动
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" 使<CR>自动选择第一个完成项，并通知coc.nvim在输入时设置格式，<cr>可能会被其他插件重新映射
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" function! CheckBackspace() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

func! CheckBackspace()
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunc


" 使用<c-space>触发补全
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


" 代码导航、跳转快捷键
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" 重命名
nmap <leader>rn <Plug>(coc-rename)

" K显示文档
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" 按住光标时突出显示该符号及其参考
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)


" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)


" 映射<C-f>和<C-b>滚动浮动窗口/弹出窗口。
" nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
" nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
" inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')
nmap <leader>f <Cmd>Format<CR>

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocActionAsync('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" set statusline^=%{coc#status()}


" " Mappings for CoCList
" " Show all diagnostics.
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" " QuickFix
" nnoremap <silent><nowait> <space>qf  :<C-u>CocList quickfix<cr>

" coc-explorer
let g:coc_explorer_global_presets = {
\   '.vim': {
\     'root-uri': '~/.vim',
\   },
\   'cocConfig': {
\      'root-uri': '~/.config/coc',
\   },
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow',
\   },
\ }

if has('nvim')
    nmap <leader><F3> <Cmd>CocCommand explorer --toggle --preset floating<CR>
else
    nmap <leader><F3> <Cmd>CocCommand explorer<CR>
endif
" Use preset argument to open it
nmap <space>ed <Cmd>CocCommand explorer --preset .vim<CR>
nmap <space>ef <Cmd>CocCommand explorer --preset floating<CR>
nmap <space>ec <Cmd>CocCommand explorer --preset cocConfig<CR>
" List all presets
nmap <space>el <Cmd>CocList explPresets<CR>


" coc 集成在airline上
let g:airline#extensions#coc#enabled = 1
" let airline#extensions#coc#error_symbol = 'E: '
" let airline#extensions#coc#warning_symbol = 'W: '
" let airline#extensions#coc#error_symbol = '💥'
" let airline#extensions#coc#warning_symbol = '⚡️'
let airline#extensions#coc#error_symbol = ''
let airline#extensions#coc#warning_symbol = ''
" let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
" let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

" 自动安装这些插件
let g:coc_global_extensions = ['coc-html','coc-css', 'coc-json',
            \ 'coc-lists','coc-markdownlint', 'coc-explorer',
            \ 'coc-emmet', 'coc-xml','coc-yaml','coc-syntax', 'coc-git', 'coc-snippets',
            \ 'coc-highlight','coc-pairs','coc-tag','coc-emoji', 'coc-omni', 'coc-pyright', 'coc-diagnostic',
            \ 'coc-tsserver', 'coc-prettier']


" 根据是否有诊断信息，来决定当鼠标悬停时，是显示文档还是显示诊断信息
function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#float#has_float() == 0 && CocHasProvider('hover') == 1)
    silent call CocActionAsync('doHover')
  endif
endfunction
function! s:show_hover_doc()
  call timer_start(300, 'ShowDocIfNoDiagnostic')
endfunction
autocmd CursorHoldI * :call <SID>show_hover_doc()
autocmd CursorHold * :call <SID>show_hover_doc()

" 文献类型映射
let g:coc_filetype_map = {
  \ 'typescript.jsx': 'typescriptreact',
  \ 'javascript.jsx': 'javascriptreact',
  \ 'javascript.js': 'javascriptreact',
  \ 'tsx': 'typescript.tsx',
  \ 'jsx': 'javascript.tsx',
  \ 'js': 'typescriptreact'
  \ }


"""

"""
Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
Plug 'junegunn/fzf.vim' " needed for previews
Plug 'antoinemadec/coc-fzf', {'branch': 'release'}

" makes fzf work related to git root of buffer which is nice
Plug 'airblade/vim-rooter'

" Allow fzf search as \t
nmap <leader>t :FZF<cr>

" Update fzf.vim actions for bindings like command-t
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-t': 'tabedit',
      \ 'ctrl-v': 'vsplit',
      \ }

" this allows the escape key to close the fzf window matching coc.nvim
if has("nvim")
  au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au FileType fzf tunmap <buffer> <Esc>
endif

" Popup window (center of the current window)
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8, 'relative': v:true } }

" Customize fzf colors to match your color scheme
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


" shortcut
" code outline
nmap <leader><F4> :CocFzfList outline<cr>

" code diagnostics
" nmap <leader><F5> :CocFzfList diagnostics<cr>
nmap <leader><F5> :CocFzfList diagnostics --current-buf<cr>

" fzf files
nmap <leader><F6> <Cmd>FZF<CR>

" fzf full-text search
nmap <leader><F7> <Cmd>Rg<CR>

" Another set of shortcuts
nnoremap <silent> <space><space> :<C-u>CocFzfList<CR>
nnoremap <silent> <space>a       :<C-u>CocFzfList diagnostics<CR>
nnoremap <silent> <space>b       :<C-u>CocFzfList diagnostics --current-buf<CR>
nnoremap <silent> <space>c       :<C-u>CocFzfList commands<CR>
nnoremap <silent> <space>e       :<C-u>CocFzfList extensions<CR>
nnoremap <silent> <space>l       :<C-u>CocFzfList location<CR>
nnoremap <silent> <space>o       :<C-u>CocFzfList outline<CR>
nnoremap <silent> <space>s       :<C-u>CocFzfList symbols<CR>
nnoremap <silent> <space>p       :<C-u>CocFzfListResume<CR>

"""

""" 支持git
Plug 'tpope/vim-fugitive'
"""

""" 平滑滚动
Plug 'psliwka/vim-smoothie'
" nnoremap <unique> <C-D> <cmd>call smoothie#do("\<C-D>") <CR>
" vnoremap <unique> <C-D> <cmd>call smoothie#do("\<C-D>") <CR>
"""

"""
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" if the warning and error sections are empty, disable them
let g:airline_skip_empty_sections = 1

" disable automatic echoing
let g:bufferline_echo = 1

let g:airline_powerline_fonts = 1

" Display a short path in statusline
" let g:airline_stl_path_style = 'short'

" powerline symbols设置
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.maxlinenr = ''
" let g:airline_symbols.spell = 'Ꞩ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.notexists = 'Ɇ'
" let g:airline_symbols.whitespace = 'Ξ'
" let g:airline_symbols.crypt = ''
" let g:airline_symbols.paste = 'Þ'
" let g:airline#extensions#tabline#left_sep = ''
" let g:airline#extensions#tabline#left_alt_sep = ''


" let g:airline_left_sep = "\uE0C0"
" let g:airline_left_alt_sep = "\uE0C1"
" let g:airline_right_sep = "\uE0C2"
" let g:airline_right_alt_sep = "\uE0C3"
" let g:airline_symbols.branch = "\uE0A0"
" let g:airline_symbols.readonly = "\uE0A2"
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.maxlinenr = "\uE0A3"
" let g:airline_symbols.whitespace = "Ξ"
" let g:airline_symbols.crypt = "\uE0A2"
" let g:airline_symbols.paste = "Þ"
" let g:airline#extensions#tabline#left_sep = "\uE0C0"
" let g:airline#extensions#tabline#left_alt_sep = "\uE0C1"

" let g:airline_left_sep = "\uE0BC"
" let g:airline_left_alt_sep = "\uE0BD"
" let g:airline_right_sep = "\uE0BE"
" let g:airline_right_alt_sep = "\uE0BF"
" let g:airline_symbols.branch = "\uE0A0"
" let g:airline_symbols.readonly = "\uE0A2"
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.maxlinenr = "\uE0A3"
" let g:airline_symbols.whitespace = "Ξ"
" let g:airline_symbols.crypt = "\uE0A2"
" let g:airline_symbols.paste = "Þ"
" let g:airline#extensions#tabline#left_sep = "\uE0BC"
" let g:airline#extensions#tabline#left_alt_sep = "\uE0BD"

" 自定义的airline的图标，这个去掉了一些
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.dirty='∓'
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = '│␤'
" let g:airline_symbols.maxlinenr = '│'
" let g:airline_symbols.colnr = ':'
" let g:airline_symbols.spell = 'Ꞩ'
" let g:airline_symbols.notexists = '∄'
" let g:airline_symbols.whitespace = ''
" let g:airline_symbols.crypt = ''
" let g:airline_symbols.paste = 'Þ'
" let g:airline#extensions#tabline#left_sep = ''
" let g:airline#extensions#tabline#left_alt_sep = ''

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '│␤'
let g:airline_symbols.maxlinenr = '│'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = ' ∄'
let g:airline_symbols.whitespace = ''
let g:airline_symbols.crypt = ''
let g:airline_symbols.paste = 'Þ'
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline_symbols.dirty=' ⧗'

" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.dirty='∓'
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = '│␤'
" let g:airline_symbols.maxlinenr = '│'
" let g:airline_symbols.colnr = ':'
" let g:airline_symbols.spell = 'Ꞩ'
" let g:airline_symbols.notexists = '∄'
" let g:airline_symbols.whitespace = ''
" let g:airline_symbols.crypt = ''
" let g:airline_symbols.paste = 'Þ'
" let g:airline#extensions#tabline#left_sep = ''
" let g:airline#extensions#tabline#left_alt_sep = ''

" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.dirty='∓'
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = '│␤'
" let g:airline_symbols.maxlinenr = '│'
" let g:airline_symbols.colnr = ':'
" let g:airline_symbols.spell = 'Ꞩ'
" let g:airline_symbols.notexists = '∄'
" let g:airline_symbols.whitespace = ''
" let g:airline_symbols.crypt = ''
" let g:airline_symbols.paste = 'Þ'
" let g:airline#extensions#tabline#left_sep = ''
" let g:airline#extensions#tabline#left_alt_sep = ''

" tabline设置，开启tabline
" let g:airline#extensions#tabline#show_tab_nr = 0
" let g:airline#extensions#tabline#show_tab_count = 1
" let g:airline#extensions#tabline#tab_nr_type= 1
" let g:airline#extensions#tabline#show_tab_type = 1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#fnamecollapse = 1
" let g:airline#extensions#tabline#fnametruncate = 0
" let g:airline#extensions#tabline#close_symbol = '×'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#close_symbol = '×'
let g:airline#extensions#tabline#show_close_button = 1



" tab name 显示样式，:p:t路径缩写和文件名，:t文件名
let g:airline#extensions#tabline#fnamemod = ":t"

let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_idx_format = {
      \ '0': '⁰',
      \ '1': '¹',
      \ '2': '²',
      \ '3': '³',
      \ '4': '⁴',
      \ '5': '⁵',
      \ '6': '⁶',
      \ '7': '⁷',
      \ '8': '⁸',
      \ '9': '⁹'
      \ }

" 设置切换tab的快捷键  切换到第i个 tab
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" 设置切换tab的快捷键  切换到前一个 tab
nmap <leader>- <Plug>AirlineSelectPrevTab
" 设置切换tab的快捷键 切换到后一个 tab
nmap <leader>= <Plug>AirlineSelectNextTab
" 设置切换tab的快捷键 退出当前的 tab
" nmap <leader>q :bp<cr>:bd #<cr>

" unique_tail
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#overflow_marker = '…'
let g:airline#extensions#tabline#buffers_label = 'BUFFERS'
let g:airline#extensions#tabline#tabs_label = 'TABS'

" 关闭状态显示空白符号计数,这个对我用处不大"
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'

"""

"""
Plug 'Yggdroot/indentLine'
let g:indentLine_color_term = 1
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_color_term = 239
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" 自动设置缩进线，下面这行，最后有一个空格
set list lcs=tab:\┆\ 
"""

"""
Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
"""

""" polyglot
Plug 'sheerun/vim-polyglot'
"""

""" devicons
Plug 'ryanoasis/vim-devicons'
"""


"""
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1
let g:rainbow_conf = {
\ 'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\ 'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\ 'operators': '_,_',
\ 'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\ 'separately': {
\   '*': {},
\   'tex': {
\     'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\   },
\   'lisp': {
\     'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\   },
\   'vim': {
\     'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\   },
\   'html': {
\     'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\   },
\   'css': 0,
\ }
\}
"""

"""
" Plug 'vim-python/python-syntax'
" let g:python_highlight_all = 1
"""

"""
Plug 'mlaursen/vim-react-snippets'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<c-x>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"""

"""
" Plug 'chemzqm/wxapp.vim'
"""

"""
" Plug 'github/copilot.vim'
" let g:copilot_no_tab_map = v:true
" inoremap <silent><expr> <TAB>
"       \ coc#pum#visible() ? coc#pum#next(1):
"       \ exists('b:_copilot.suggestions') ? copilot#Accept("\<CR>") :
"       \ CheckBackSpace() ? "\<Tab>" :
"       \ coc#refresh()
" let g:copilot_no_tab_map = v:true
" imap <silent><script><expr> <C-y> copilot#Accept("\<CR>")
"""

""""""""" --->结束<--- """""""""
call plug#end()


"""""""""""""""
"""Shortcuts"""
"""""""""""""""

" 保存快捷键
nmap <leader>w :w!<CR>

" 设置切换Buffer快捷键
nnoremap <C-n> :bn<CR>
nnoremap <C-N> :bp<CR>

" 关闭当前buffer快捷键
" map <leader>bd :Bclose<cr>:tabclose<cr>gT

" 在panel面板之间切换快捷键
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" 竖直分屏快捷键
nnoremap <leader>vs <C-w>v
nnoremap <leader>hs <C-w>s

" 调整面板（分屏）大小
nnoremap <silent> + :exe "resize " . (winheight(0) * 4/3)<CR>
nnoremap <silent> _ :exe "resize " . (winheight(0) * 3/4)<CR>
nnoremap <silent> > :exe "vertical resize " . (winwidth(0) * 4/3)<CR>
nnoremap <silent> < :exe "vertical resize " . (winwidth(0) * 3/4)<CR>

" 操作tabs的快捷键
" map <leader>tn :tabnew<cr>
" map <leader>to :tabonly<cr>
" map <leader>tc :tabclose<cr>
" map <leader>tm :tabmove
" map <leader>t :tabnext<cr>
" map <leader>T :tabprevious<cr>

" 在当前buffer所在的目录打开一个新的tab，非常有用
" map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/


" 设置折叠快捷键
nnoremap <space> za
vnoremap <space> zf
nnoremap <leader><space> zO
vnoremap <leader><space> zf


" 新建py文件自动添加头部信息
func! g:HeaderPython()
  let line = getline(1)
  call setline(1, "#!/usr/bin/env python")

  call append(1, line)
  call append(1, "")
  call append(1, "")
  call append(1, "# @Description :  Powered by GitOPEN")
  call append(1, "# @Date   :  " . strftime('%Y-%m-%d %T', localtime()))
  call append(1, "# @Email  :  gitopen@gmail.com")
  call append(1, "# @Author :  GitOPEN")
  call append(1, "# Copyright (c) " . strftime('%Y', localtime()))
  call append(1, "")
  call append(1, "# -*- coding:utf-8 -*-")

  normal G
  normal o
  normal o
endfunc
autocmd bufnewfile *.py call HeaderPython()
map <Leader><F9> :call HeaderPython()<CR>

" 搜索高亮设置
" 当光标一段时间保持不动了，就禁用高亮
autocmd cursorhold * set nohlsearch
" 当输入查找命令时，再启用高亮
noremap n :set hlsearch<cr>n
noremap N :set hlsearch<cr>N
noremap / :set hlsearch<cr>/
noremap ? :set hlsearch<cr>?
noremap * *:set hlsearch<cr>

" visual模式下快速对齐
vnoremap < <gv
vnoremap > >gv


""""""""""""
"""Others"""
""""""""""""

" 根据 文件类型设置 tab键是否为空格，以及空格的个数
func! SetTabType()
    if &filetype == 'javascript' ||  &filetype == 'javascriptreact' || &filetype == 'typescript' ||  &filetype == 'typescriptreact'
      set tabstop=2
      set softtabstop=2
      set shiftwidth=2
    elseif &filetype == 'html' ||  &filetype == 'css' ||  &filetype == 'markdown'
      set tabstop=2
      set softtabstop=2
      set shiftwidth=2
    else
      " 表示一个 tab 显示出来是多少个空格的长度
      set tabstop=4
      " 表示在编辑模式的时候按退格键的时候退回缩进的长度
      set softtabstop=4
      " 表示每一级缩进的长度，一般设置成跟 softtabstop 一样
      set shiftwidth=4 
    endif                                                                              
endfunc
autocmd BufRead * call SetTabType()
" 当设置成 expandtab 时，缩进用空格来表示，noexpandtab 则是用制表符表示一个缩进
set expandtab

" 打开文件是默认不折叠代码
" set foldlevelstart=99

"打开一个文件自动定位到上一次退出的位置
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" 保存.vim文件后不用退出即可生效
" au! bufwritepost .vimrc source %

" preview窗口自动关闭
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" preview窗口在下方显示
set splitbelow


set nu
set relativenumber
set cursorline
" set cursorcolumn
set nowrap
set showmatch
set incsearch
set undofile
set autochdir
" set visualbell
set novisualbell
set autoread
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8

" 交换文件选项，交换文件保存时间与字符数
" 每 400 字符保存一次
set updatecount=50
" 每 30000 毫秒，即 30 秒保存一次
set updatetime=30000

" 开启文件备份
set backup
" 为每个文件保留多个备份
autocmd BufWritePre * let &backupext = strftime(".%Y-%m-%d_%H")

" 隐藏缓冲区, 无需保存即可切换 buffer
set hidden
" 重用已打开的 buffer
set switchbuf=useopen

" 文件改变自动读入，就像协作一样
set autoread
autocmd FocusGained,BufEnter * checktime

" 关闭滚动条
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" 设定光标离窗口上下边界 3 行时窗口自动滚动
set scrolloff=16
set sidescrolloff=1

" 开启鼠标
set mouse=a

" vim statusline不显示当前模式
" set noshowmode

" Turn on the Wild menu
" set wildmenu
" set wildmode=list:longest,full

" 开启 omni 补全
set omnifunc=syntaxcomplete#Complete

" 关闭自带的 netrw
let g:loaded_netrw=1
let g:loaded_netrwPlugin=1

" 主题颜色及字体
if has('termguicolors')
   set termguicolors
endif
" set t_Co=256
syntax enable

" let g:airline_theme='dracula'
" colorscheme dracula

let g:airline_theme='gruvbox'
colorscheme gruvbox
" soft, medium, hard
let g:gruvbox_contrast_dark='hard'
set background=dark

" let g:airline_theme='base16'
" colorscheme tokyonight-night
" colorscheme tokyonight
" colorscheme tokyonight-storm
" colorscheme tokyonight-day
" colorscheme tokyonight-moon

" set guifont=JetBrainsMono\ Nerd\ Font\ Mono:h10
" set guifont=Sarasa\ Mono\ SC\ Nerd:h12
" set guifont=Sarasa\ Mono\ SC\ Nerd:h12
set guifont=Monego\ Nerd\ Font\ Fix:h12


""" 备份文件夹位置
if !has('nvim')
    set backupdir=~/.vim/.backup//
    set directory=~/.vim/.swp//
    set undodir=~/.vim/.undo//
else
    set backupdir=~/.config/nvim/.backup//
    set directory=~/.config/nvim/.swp//
    set undodir=~/.config/nvim/.undo//
endif
