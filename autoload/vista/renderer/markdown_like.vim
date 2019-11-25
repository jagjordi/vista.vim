" Copyright (c) 2019 Liu-Cheng Xu
" MIT License
" vim: ts=2 sw=2 sts=2 et

scriptencoding utf-8

let s:default_icon = get(g:, 'vista_icon_indent', ['└▸ ', '├▸ '])

" Given the metadata of headers of markdown, return the rendered lines to display.
"
" The metadata of markdown headers is a List of Dict:
" {'lnum': 1, 'level': '4', 'text': '# Vista.vim'}
function! s:MD(line) abort
  let line = a:line

  let text = line.text
  let lnum = line.lnum
  let level = line.level
  let row = repeat(' ', 2 * (level - 1)).s:default_icon[0].text.' H'.level.':'.lnum

  return row
endfunction

" The metadata of rst headers is a List of Dict:
" {'lnum': 1, 'level': '4', 'text': 'Vista.vim'}
function! s:RST(line) abort
  let line = a:line

  let level = line.level
  let text = vista#util#Trim(line['text'])
  " line.lnum is 0-based, but the lnum of vim is 1-based.
  let lnum = line.lnum + 1

  let row = repeat(' ', 2 * (level - 1)).s:default_icon[0].text.' H'.level.':'.lnum

  return row
endfunction

" markdown
function! vista#renderer#markdown_like#MD(data) abort
  return map(a:data, 's:MD(v:val)')
endfunction

" restructuredText
function! vista#renderer#markdown_like#RST(data) abort
  return map(a:data, 's:RST(v:val)')
endfunction
