#!/bin/sh

#
# Prettifies svn authors in git-svn authors-file format. e.g. loginname = Joe User <user@example.com>
#
svnauthors=$(svn log --xml --quiet | grep author | sort -u | perl -pe 's/.*>(.*?)<.*/$1/')
for userid in $svnauthors; do
  echo $userid=$(author.sh $userid)
done
