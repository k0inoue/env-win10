" default preview command
let $FZF_PREVIEW_COMMAND='bat --color=always --style=header --line-range :60 {}'

" target for current directory bellow
let g:rooter_change_directory_for_non_project_files = 'current'
let g:fzf_layout = { 'down': '70%' }
let g:fzf_tags_command = 'ctags'
"let g:fzf_buffers_jump = 1
"let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" keybinds on fzf window
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" open files with preview
 command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:60%:wrap','?'), <bang>0)


 " grep with ripgrep
 command! -bang -nargs=* Rg
   \ call fzf#vim#grep(
   \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
   \   <bang>0 ? fzf#vim#with_preview('up:60%')
   \           : fzf#vim#with_preview('right:50%:hidden', '?'),
   \   <bang>0)

" select colors
command! -bang Colors
   \ call fzf#vim#colors({'left': '20', 'options': '--reverse --margin   30%,0'}, <bang>0)

" complete example
" function! s:make_sentence(lines)
"   return substitute(join(a:lines), '^.', '\=toupper(submatch(0))', '').'.'
" endfunction
" inoremap <expr> <c-x><c-s> fzf#vim#complete({
"   \ 'source':  'cat /usr/share/dict/words',
"   \ 'reducer': function('<sid>make_sentence'),
"   \ 'options': '--multi --reverse --margin 15%,0',
"   \ 'left':    20})

