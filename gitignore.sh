#!/bin/sh
#
# Ignore common files for Java development.
#
rm .gitignore
echo "Generated by Git Migration from https://github.com/github/gitignore\n\n"
echo "\n#\n# Java\n#\n" >>.gitignore
curl --insecure https://raw.githubusercontent.com/github/gitignore/master/Java.gitignore >>.gitignore
echo "\n#\n# Maven\n#\n" >>.gitignore
curl --insecure https://raw.githubusercontent.com/github/gitignore/master/Maven.gitignore >>.gitignore
echo "\n#\n# Windows\n#\n" >>.gitignore
curl --insecure https://raw.githubusercontent.com/github/gitignore/master/Global/Windows.gitignore >>.gitignore
echo "\n#\n# Linux\n#\n" >>.gitignore
curl --insecure https://raw.githubusercontent.com/github/gitignore/master/Global/Linux.gitignore >>.gitignore
echo "\n#\n# Diff\n#\n" >>.gitignore
curl --insecure https://raw.githubusercontent.com/github/gitignore/master/Global/Diff.gitignore >>.gitignore
echo "\n#\n# Subversion\n#\n" >>.gitignore
curl --insecure https://raw.githubusercontent.com/github/gitignore/master/Global/SVN.gitignore >>.gitignore
echo "\n#\n# Eclipse\n#\n" >>.gitignore
curl --insecure https://raw.githubusercontent.com/github/gitignore/master/Global/Eclipse.gitignore >>.gitignore
echo "\n#\n# Cloud9\n#\n" >>.gitignore
curl --insecure https://raw.githubusercontent.com/github/gitignore/master/Global/Cloud9.gitignore >>.gitignore
echo "\n#\n# TortoiseGit\n#\n" >>.gitignore
curl --insecure https://raw.githubusercontent.com/github/gitignore/master/Global/TortoiseGit.gitignore >>.gitignore
echo "\n#\n# NotepadPP\n#\n" >>.gitignore
curl --insecure https://raw.githubusercontent.com/github/gitignore/master/Global/NotepadPP.gitignore >>.gitignore
echo "\n#\n# Vim\n#\n" >>.gitignore
curl --insecure https://raw.githubusercontent.com/github/gitignore/master/Global/Vim.gitignore >>.gitignore
echo "\n#\n# macOS\n#\n" >>.gitignore
curl --insecure https://raw.githubusercontent.com/github/gitignore/master/Global/macOS.gitignore >>.gitignore
echo "\n#\n# Custom\n#\n" >>.gitignore