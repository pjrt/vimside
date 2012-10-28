" ============================================================================
" debug_thread_start.vim
"
" File:          vimside#swank#event#debug_thread_start.vim
" Summary:       Vimside Debug thread_start
" Author:        Richard Emberson <richard.n.embersonATgmailDOTcom>
" Last Modified: 2012
" Version:       1.0
" Modifications:
"
" Tested on vim 7.3 on Linux
"
" Depends upon: NONE
"
" ============================================================================
" Intro: {{{1
"
" ============================================================================

let s:LOG = function("vimside#log#log")
let s:ERROR = function("vimside#log#error")

function! vimside#swank#event#debug_thread_start#Handle(...)
call s:LOG("vimside#swank#event#debug_thread_start#Handle: ". string(a:000))
endfunction
