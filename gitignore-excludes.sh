#!/bin/sh

count=$(ls -1 bin/*.sh bin/*.cmd bin/*.bat 2>/dev/null | wc -l)
if [ $count -gt 1 ]; then
    echo "bin has scripts - excluding from ignored files."
    sed -i '/^bin.*$/d' .gitignore
fi
