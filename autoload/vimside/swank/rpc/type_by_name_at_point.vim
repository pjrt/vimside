" ============================================================================
" type_by_name_at_point.vim
"
" File:          vimside#swank#rpc#type_by_name_at_point.vim
" Summary:       Vimside RPC type-by-name-at-point
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
" Lookup a type by name, in a specific source context.
"
" Arguments:
"   String:The local or qualified name of the type.
"   String:A source filename.
"   Int:A character offset in the file.
"
" Return:
"   A TypeInfo
"
" Example:
"
" (:swank-rpc (swank:type-by-name-at-point "String" "SwankProtocol.scala" 31680) 42)
"
" (:return 
" (:ok 
" (:name "String" :type-id 1188 :full-name
" "java.lang.String" :decl-as class)
" 42)
"
" ============================================================================

let s:LOG = function("vimside#log#log")
let s:ERROR = function("vimside#log#error")


" public API
function! vimside#swank#rpc#type_by_name_at_point#Run(...)
call s:LOG("type_by_name_at_point TOP") 

  if ! exists("s:Handler")
    let s:Handler = vimside#swank#rpc#util#LoadFuncrefFromOption('swank-rpc-type-by-name_at_point-handler')
    let s:Caller = vimside#swank#rpc#util#LoadFuncrefFromOption('swank-rpc-type-by-name_at_point-caller')
  endif

  let l:args = { }
  let l:rr = vimside#swank#rpc#util#MakeRPCEnds(s:Caller, l:args, s:Handler, a:000)
  " call vimside#ensime#swank#dispatch(l:rr)

  let msg = "Not Implemented Yet:" . 'swank-rpc-type-by-name_at_point-handler'
  call s:Error(msg)
  echoerr msg

call s:LOG("type_by_name_at_point BOTTOM") 
endfunction


"======================================================================
" Vimside Callers
"======================================================================

function! g:TypeByNameAtPointCaller(args)
  let cmd = "swank:type-by-name_at_point"

  return '('. cmd .')'
endfunction


"======================================================================
" Vimside Handlers
"======================================================================

function! g:TypeByNameAtPointHandler()

  function! g:TypeByNameAtPointHandler_Abort(code, details, ...)
    call call('vimside#swank#rpc#util#Abort', [a:code, a:details] + a:000)
  endfunction

  function! g:TypeByNameAtPointHandler_Ok(sexp_rval)
call s:LOG("TypeByNameAtPointHandler_Ok ".  vimside#sexp#ToString(a:sexp_rval)) 
    let [found, dic] = vimside#sexp#Convert_KeywordValueList2Dictionary(a:sexp_rval) 
    if ! found 
      echoe "TypeByNameAtPoint ok: Badly formed Response"
      call s:ERROR("TypeByNameAtPoint ok: Badly formed Response: ". string(a:sexp_rval)) 
      return 0
    endif
call s:LOG("TypeByNameAtPointHandler_Ok dic=".  string(dic)) 

    let l:pid = dic[':pid']



    return 1

  endfunction

  return { 
    \ 'abort': function("g:TypeByNameAtPointHandler_Abort"),
    \ 'ok': function("g:TypeByNameAtPointHandler_Ok") 
    \ }
endfunction
