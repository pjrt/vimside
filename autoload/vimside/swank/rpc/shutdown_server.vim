" ============================================================================
" shutdown_server.vim
"
" File:          vimside#swank#rpc#shutdown_server.vim
" Summary:       Vimside RPC shutdown-server
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
" Politely ask the server to shutdown.
"
" Arguments: None
"
" Return: None
"
" Example:
"
" (swank:shutdown-server)
" (:return (:ok t) 4)
"
" ============================================================================

let s:LOG = function("vimside#log#log")
let s:ERROR = function("vimside#log#error")


" public API
function! vimside#swank#rpc#shutdown_server#Run(...)
call s:LOG("ShutdownServer TOP") 

  if ! exists("s:Handler")
    let s:Handler = vimside#swank#rpc#util#LoadFuncrefFromOption('swank-rpc-shutdown-server-handler')
    let s:Caller = vimside#swank#rpc#util#LoadFuncrefFromOption('swank-rpc-shutdown-server-caller')
  endif

  let l:args = { }
  let l:rr = vimside#swank#rpc#util#MakeRPCEnds(s:Caller, l:args, s:Handler, a:000)
  call vimside#ensime#swank#dispatch(l:rr)

call s:LOG("ShutdownServer BOTTOM") 
endfunction


"======================================================================
" Vimside Callers
"======================================================================

function! g:ShutdownServerCaller(args)
  let cmd = "swank:shutdown-server"

  return '(' . cmd . ')'
endfunction


"======================================================================
" Vimside Handlers
"======================================================================

function! g:ShutdownServerHandler()

  function! g:ShutdownServerHandler_Abort(code, details, ...)
    call call('vimside#swank#rpc#util#Abort', [a:code, a:details] + a:000)
  endfunction

  function! g:ShutdownServerHandler_Ok(okResp)
" call s:LOG("ShutdownServerHandler_Ok " .  vimside#sexp#ToString(a:okResp)) 
    let [found, diclist] = vimside#sexp#Convert_KeywordValueList2Dictionary(a:okResp) 
    if ! found 
      echoe "ShutdownServer ok: Badly formed Response"
      call s:ERROR("ShutdownServer ok: Badly formed Response: ". string(a:okResp)) 
      return 0
    endif

" call s:LOG("ShutdownServerHandler_Ok diclist=".  string(diclist)) 


    let msg = "Ensime Server Shutdown"
    call vimside#cmdline#Display(msg) 
    return 1
  endfunction

  return { 
    \ 'abort': function("g:ShutdownServerHandler_Abort"),
    \ 'ok': function("g:ShutdownServerHandler_Ok") 
    \ }
endfunction
