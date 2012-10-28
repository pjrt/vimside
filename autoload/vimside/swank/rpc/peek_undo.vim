" ============================================================================
" peek_undo.vim
"
" File:          vimside#swank#rpc#peek_undo.vim
" Summary:       Vimside RPC peek-undo
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
" The intention of this call is to preview the effect of an undo before
"  executing it.
"
" Arguments: None
"
" Return:
"   (
"   :id //Int:Id of this undo
"   :changes //List of Changes:Describes changes
"   this undo would effect.
"   :summary //String:Summary of action
"   this undo would revert.
"   )
"
" Example:
"
" (:swank-rpc (swank:peek-undo) 42)
"
" (:return 
" (:ok 
" (:id 1 
" :changes (
" (
" :file "/ensime/src/main/scala/org/ensime/server/RPCTarget.scala"
" :text "rpcInitProject" 
" :from 2280 :to 2284
" ) )
" :summary "Refactoring of type: 'rename")
" 42)
"
" ============================================================================

let s:LOG = function("vimside#log#log")
let s:ERROR = function("vimside#log#error")


" public API
function! vimside#swank#rpc#peek_undo()
call s:LOG("peek_undo TOP") 

  if ! exists("s:Handler")
    let s:Handler = vimside#swank#rpc#util#LoadFuncrefFromOption('swank-rpc-peek-undo-handler')
    let s:Caller = vimside#swank#rpc#util#LoadFuncrefFromOption('swank-rpc-peek-undo-caller')
  endif

  let l:args = { }
  let l:rr = vimside#swank#rpc#util#MakeRPCEnds(s:Caller, l:args, s:Handler, a:000)
  " call vimside#ensime#swank#dispatch(l:rr)

  let msg = "Not Implemented Yet:" . 'swank-rpc-peek-undo-handler'
  call s:Error(msg)
  echoerr msg

call s:LOG("peek_undo BOTTOM") 
endfunction


"======================================================================
" Vimside Callers
"======================================================================

function! g:PeekUndoCaller(args)
  let cmd = "swank:peek-undo"

  return '('. cmd .')'
endfunction


"======================================================================
" Vimside Handlers
"======================================================================

function! g:PeekUndoHandler()

  function! g:PeekUndoHandler_Abort(code, details, ...)
    call call('vimside#swank#rpc#util#Abort', [a:code, a:details] + a:000)
  endfunction

  function! g:PeekUndoHandler_Ok(peekUndo)
call s:LOG("PeekUndoHandler_Ok ".  vimside#sexp#ToString(a:peekUndo)) 
    let [found, dic] = vimside#sexp#Convert_KeywordValueList2Dictionary(a:peekUndo) 
    if ! found 
      echoe "PeekUndo ok: Badly formed Response"
      call s:ERROR("PeekUndo ok: Badly formed Response: ". string(a:peekUndo)) 
      return 0
    endif
call s:LOG("PeekUndoHandler_Ok dic=".  string(dic)) 

    let l:pid = dic[':pid']



    return 1

  endfunction

  return { 
    \ 'abort': function("g:PeekUndoHandler_Abort"),
    \ 'ok': function("g:PeekUndoHandler_Ok") 
    \ }
endfunction
