# open.kak

Kakoune plugin to browse directories. Inspired by [vim-dirvish](https://github.com/justinmk/vim-dirvish).

## Features

`open <directory>` opens a new buffer listing the contents of the directory. Press `<ret>`
to open the file or directory on the current line. Press `<c-l>` to refresh.

## Example configuration

```kak
map global normal <minus> ': open %sh{dirname "$kak_bufname"}<ret>'
```
