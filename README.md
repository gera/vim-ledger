vim-ledger
==========

Syntax, middle-of-the-word autocomple (eg: `bank` to a previously mentioned
`assets:bank`) and useful functions (eg, toggle cleared state for
transactions) for managing ledger files with vim.

Usage
-----

For all `*.ledger` files, it automatically sets up the syntax highlighting. Use
`F3` to toggle the cleared status of a transaction and `<C-K>` to autocomplete
transaction titles (usually payees by ledger convention) and accounts.

The completion is fairly naïve and just completes words/titles. Specifically,
it makes no attempts to exclude words from within comments.

Customization
-------------

Syntax highlighting (colours, currencies etc) are defined in
`syntax/ledger.vim` and kay mappings in  `plugin/ledger.vim`

Installation
------------

With pathogen
~~~~~~~~~~~~~

Clone the repo in your `~/.vim/bundle/` directory and you should be set.

Without pathogen
~~~~~~~~~~~~~~~~

Put the individual `.vim` files in the corresponding vim directories (eg,
`~/.vim/plugin` etc).

License
-------

This is public domain and comes with no warranties, explicit or implied. I
would bet on it having many issues and wouldn't vouch for its fitness for any
purpose. Use at your own risk.

