au BufRead,BufNewFile *.ledger set filetype=ledger
au BufRead,BufNewFile *.ledger python update_words()
au BufWritePost *.ledger python update_words()

