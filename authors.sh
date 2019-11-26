#!/bin/sh
#
# Prettifies svn authors in git authors-file format.
#
svnauthors=$(svn log --xml --quiet | grep author | sort -u | perl -pe 's/.*>(.*?)<.*/$1/')
for userid in $svnauthors; do
  echo $userid=$(author.sh $userid)
done
