" ============================================================================
" debug_continue.vim
"
" File:          vimside#swank#rpc#debug_continue.vim
" Summary:       Vimside RPC debug-continue
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
" Resume execution of the VM.
"
" Arguments:
"   String:The thread-id to continue.
"
" Return: None
" 
" Example:
"
" (:swank-rpc (swank:debug-continue "1") 42)
"
" (:return 
" (:ok t)
" 42)
"
" ============================================================================

let s:LOG = function("vimside#log#log")
let s:ERROR = function("vimside#log#error")


" public API
function! vimside#swank#rpc#debug_continue#Continue()
call s:LOG("debug_continue TOP") 

  if ! exists("s:Handler")
    let s:Handler = vimside#swank#rpc#util#LoadFuncrefFromOption('swank-rpc-debug-continue-handler')
    let s:Caller = vimside#swank#rpc#util#LoadFuncrefFromOption('swank-rpc-debug-continue-caller')
  endif

  let l:args = { }
  let l:rr = vimside#swank#rpc#util#MakeRPCEnds(s:Caller, l:args, s:Handler, a:000)
  " call vimside#ensime#swank#dispatch(l:rr)

  let msg = "Not Implemented Yet:" . 'swank-rpc-debug-continue-handler'
  call s:Error(msg)
  echoerr msg

call s:LOG("debug_continue BOTTOM") 
endfunction


"======================================================================
" Vimside Callers
"======================================================================

function! g:DebugContinueCaller(args)
  let cmd = "swank:debug-continue"

  return '('. cmd .')'
endfunction


"======================================================================
" Vimside Handlers
"======================================================================

function! g:DebugContinueHandler()

  function! g:DebugContinueHandler_Abort(code, details, ...)
    call call('vimside#swank#rpc#util#Abort', [a:code, a:details] + a:000)
  endfunction

  function! g:DebugContinueHandler_Ok(sexp_rval)
call s:LOG("DebugContinueHandler_Ok ".  vimside#sexp#ToString(a:sexp_rval)) 
    let [found, dic] = vimside#sexp#Convert_KeywordValueList2Dictionary(a:sexp_rval) 
    if ! found 
      echoe "DebugContinue ok: Badly formed Response"
      call s:ERROR("DebugContinue ok: Badly formed Response: ". string(a:sexp_rval)) 
      return 0
    endif
call s:LOG("DebugContinueHandler_Ok dic=".  string(dic)) 

    let l:pid = dic[':pid']



    return 1

  endfunction

  return { 
    \ 'abort': function("g:DebugContinueHandler_Abort"),
    \ 'ok': function("g:DebugContinueHandler_Ok") 
    \ }
endfunction
