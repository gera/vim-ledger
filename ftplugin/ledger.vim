
python <<EOFN

import re
from collections import defaultdict
rTxnStart = re.compile(r'^(?P<date>\d+/\d+)\s+(?P<mark>\*\s+|\!\s+|)(?P<rest>[^*!]+)')

words = defaultdict(lambda: 0)

def update_words():
    import vim
    global words
    cb = vim.current.buffer
    for line in cb:
        match = rTxnStart.match(line)
        if match:
            words[match.group("rest")] += 1
        else:
            for wd in line.lower().split():
                if ':' in wd:
                    words[wd] += 1

def isblank(line):
    return re.match(r'^\s*$', line) is not None

def is_txn_start(line):
    return rTxnStart.match(line) is not None

def toggle(s):
    return {'*': ' ', '!': ' ', '': '*'}.get(s, ' ')

def get_block_start():
    import vim
    if isblank(vim.current.line):
        return None
    cb = vim.current.buffer
    row = vim.current.window.cursor[0]-1
    for rownum in range(row, -1, -1):
        if is_txn_start(cb[rownum]):
            return rownum
        if isblank(cb[rownum]):
            return None
    return None

def toggle_transaction():
    import vim
    import re
    rownum = get_block_start()
    cb = vim.current.buffer
    if rownum is None:
        print "no transaction under the cursor"
        return
    date, mark, rest = rTxnStart.match(cb[rownum]).groups()
    buf_num = cb.number
    b = vim.buffers[buf_num-1]
    b[rownum] = "%s %s %s" % (date, toggle(mark), rest)
    print "transaction state toggled on row", rownum

EOFN

function! Ledger_complete(word)
python <<EOFN
import vim

def ledger_completion(word):
    global words
    return sorted(filter(lambda w: word in w, words.keys()), key=lambda w: words[w], reverse=True)

wd = vim.eval('a:word')
vim.command('let g:ledger_compl_ret='+str(ledger_completion(wd)))
EOFN
    return g:ledger_compl_ret
endfunction

function! Ledger_completion(findstart, base)
python <<EOFN
import vim

def find_start():
    line = vim.current.line
    startcol = vim.current.window.cursor[1]-1
    match = rTxnStart.match(line)
    if match:
        if not match.group('rest'):
            return match.endpos
        return line.index(match.group('rest'))
    else:
        while startcol > 1:
            if line[startcol-1] == ' ' and line[startcol-2] == ' ':
                return startcol
            startcol -= 1
        return startcol+1

def get_start():
    vim.command('let l:start_pos='+str(find_start()))
EOFN
    if a:findstart
        python get_start()
        return l:start_pos
    else
        return Ledger_complete(a:base)
endfunction

inoremap <F3> <ESC>:python toggle_transaction()<CR>i
nnoremap <F3> :python toggle_transaction()<CR>
vnoremap <F3> :python toggle_transaction()<CR>
set iskeyword=@,48-57,_,:,192-255 
set completefunc=Ledger_completion
inoremap <C-K> <C-X><C-U>

