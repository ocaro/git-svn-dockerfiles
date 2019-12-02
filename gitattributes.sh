#!/bin/sh
#
# Generates a gitattributes file to manage text file in Unix-style.
#
echo " \
*   text=auto \n \
*.sh text   eol=lf \n \
" > .gitattributes
# Renormalize to fix existing files.
# git add --all --renormalize
