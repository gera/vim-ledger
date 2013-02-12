" Vim syntax file

if exists("b:current_syntax")
    finish
endif

syn match   directive               '^[A-Z].*'
syn match   amount                  '\d\+\.\d\+'
syn match   amount                  '\d\+'
syn match   amount                  '- \d\+\.\d\+'
syn match   amount                  '- \d\+'
syn match   comment                 ';.*$' contains=todo
syn match   titleline               '^\d\+\/\d\+\s\+.*$' contains=date contains=title
syn match   account                 '[a-zA-Z:]\+'
syn match   date        contained   '\d\+\/\d\+'
syn keyword todo        contained   TODO FIXME XXX NOTE
syn keyword currencies              EUR INR USD nextgroup=amount skipwhite

let b:current_syntax = "ledger"
hi def link todo        Todo
hi def link comment     Comment
hi def link amount      Constant
hi def link currencies  Identifier
hi def link date        Keyword
hi def link directive   Label
hi def link account     Define
