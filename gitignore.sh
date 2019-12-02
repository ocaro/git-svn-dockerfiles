#!/bin/sh
#
# Ignore common files for Java development.
#
append_banner() {
  if [ $# -eq 0 ]; then
    echo "err: need banner text." >&2
  fi
  echo "\n#\n# $1\n#\n" >>.gitignore
}
append_download() {
  if [ $# -eq 0 ]; then
    echo "err: need a relative uri to download." >&2
  fi
  append_banner "$(basename -s .gitignore $1)"
  curl --insecure https://raw.githubusercontent.com/github/gitignore/master/$1 >>.gitignore
}
rm .gitignore
append_banner "Generated from https://github.com/github/gitignore"
append_download Global/Archives.gitignore
append_download Global/Cloud9.gitignore
append_download Global/Diff.gitignore
append_download Global/Eclipse.gitignore
append_download Global/Linux.gitignore
append_download Global/macOS.gitignore
append_download Global/NotepadPP.gitignore
append_download Global/SVN.gitignore
append_download Global/TortoiseGit.gitignore
append_download Global/Vim.gitignore
append_download Global/Windows.gitignore
append_download Java.gitignore
append_download Maven.gitignore
append_banner "Custom"
