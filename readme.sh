#!/bin/sh
if [ ! -f README.md ]; then
  touch README.md
fi
if [ $# -eq 0 ]; then
  echo "Usage: $(basename $0) title"
  exit 1
fi
echo "# $@" > README.md
git add README.md