#!/bin/sh
cp $(dirname $0)/gitattributes.txt .gitattributes
git add .gitattributes
git add --all --renormalize
