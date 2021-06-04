" Vim syntax file
" Language: Jamal Simulator Script (https://github.com/JamalMulla/Simulator)
" Maintainer: Tanuj Dhir
" Latest Revision: 18 May 2021

if exists("b:current_syntax")
  finish
endif

" syn case ignore
syn case match

syn keyword basicLanguageKeywords north east south west
highlight link basicLanguageKeywords String

syn match Comment /\/\/.*/

syn match Fn /\v[_a-z0-9]+/
highlight link Fn Function

syn match Reg /[A-Z0-9]/
highlight link Reg Identifier

syn match Paren /[()]/
highlight link Paren Special
