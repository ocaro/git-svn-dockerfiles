#!/bin/sh

#
# Use to generate a .gitignore file for Java development on *nix and Windows. 
#
print_banner() {
  if [ $# -eq 0 ]; then
    echo "err: need banner text." >&2
  fi
  printf "\n#\n# $1\n#\n" $1
}
print_download() {
  if [ $# -eq 0 ]; then
    echo "err: need a relative uri to download." >&2
  fi
  print_banner "$(basename $1)"
  curl --insecure --connect-timeout 3 --silent https://raw.githubusercontent.com/github/gitignore/master/$1
  if [ $? -ne 0 ]; then
    echo "err: failed to download; status=$?; file=$1" >&2
    exit 1
  fi
}
print_banner "Note: To add more see Custom at the bottom of the file."
print_banner "Generated from https://github.com/github/gitignore"
print_download Global/Archives.gitignore
print_download Global/Cloud9.gitignore
print_download Global/Diff.gitignore

print_download Global/Eclipse.gitignore
print_banner "Eclipse - Ignores not in Global."
printf ".classpath\n"
printf ".project\n"

print_download Global/JetBrains.gitignore
print_banner "JetBrains - Ignores not in Global."
printf ".idea\n"
printf "*.iml\n"
printf "*.ipr\n"

print_download Global/Linux.gitignore
print_download Global/macOS.gitignore
print_download Global/NetBeans.gitignore
print_download Global/NotepadPP.gitignore
print_download Global/SVN.gitignore
print_download Global/TortoiseGit.gitignore
print_download Global/Vim.gitignore
print_download Global/Windows.gitignore
print_download Java.gitignore
print_download Maven.gitignore

print_banner "Git - Ignores not in Global."
printf ".git-rewrite\n"

print_banner "Custom - Your additions below this line!"
