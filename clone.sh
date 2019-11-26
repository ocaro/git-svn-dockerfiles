#!/bin/sh

print_usage() {
  echo "Usage: $(basename $0) <svn url> <git project>"
  exit 1
}

print_cloning() {
  echo "Cloning $svn_url as $git_project"
}

svn_url="$1"
git_project=$2

if [ ! -f authors.txt ]; then
  touch authors.txt
fi
if [ -z $git_project ]; then
  echo "err: project name not set."
  print_usage
fi
if [ -z $svn_url ]; then
  echo "err: svn repository url not set."
  print_usage
fi
if [ -z authors.txt ]; then
  echo "err: svn commit authors file not found."
  print_usage
fi
print_cloning
git svn clone  \
  --no-metadata \
  --stdlayout \
  --branches=/branch --branches=/branches \
  --authors-file=authors.txt --authors-prog=author.sh \
  --ignore-paths="^[^/]+/(?:target|.settings)" \
  $svn_url $git_project
