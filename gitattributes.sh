#!/bin/sh

#
# Use to generate a .gitattributes file to store text files in *nix format.
#
printf "*   text=auto\n*.sh text eol=lf\n"
# Renormalize to fix existing files.
# git add --all --renormalize
