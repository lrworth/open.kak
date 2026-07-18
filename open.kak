declare-option -hidden str open_selection

  evaluate-commands -draft %{
define-command -hidden open-refresh-buffer %{
    execute-keys %{x"oy}
    execute-keys %{%|ls -p "${kak_bufname}"<ret>}
    try %{
      execute-keys %{gg/^<c-r>o<ret>gi}
      set-option window open_selection %val{selections_desc}
    }
  }
  try %{
    select %opt{open_selection}
  }
}

define-command -hidden open-current-line %{
  evaluate-commands -draft %{
    execute-keys %{giGL}
    set-option window open_selection %val{selection}
  }
  open "%val{bufname}%opt{open_selection}"
}

define-command -params 1 open %{
  try %{edit %arg{1}} catch %{
    edit -scratch %sh{
      name="${1%/}"
      name=${name/#\~/$HOME}/
      name=${name/#\.\//$PWD/}
      echo "${name}"
    }
    open-refresh-buffer
    hook buffer WinDisplay .* open-refresh-buffer
    map buffer normal <c-l> %{: open-refresh-buffer<ret>}
    map buffer normal <ret> %{: open-current-line<ret>}
  }
}
