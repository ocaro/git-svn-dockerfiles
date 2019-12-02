#!/bin/sh
#
# Clones a repo from svn to git.
#
print_usage() {
  echo "Usage: $(basename $0) <svn url> <git repo name>"
  exit 1
}
print_cloning() {
  echo "Cloning $svn_url as $git_repository_name"
}

svn_url="$1"
git_repository_name=$2

if [ -z $svn_url ]; then
  echo "err: svn repository url not set." >&2
  print_usage
fi
if [ -z $git_repository_name ]; then
  echo "err: project name not set." >&2
  print_usage
fi
if [ -f authors.txt ]; then
  echo "err: git authors.txt file not found." >&2
  print_usage
fi
print_cloning
git svn clone \
  --no-metadata \
  --stdlayout \
  --branches=/branch --branches=/branches \
  --authors-file=authors.txt --authors-prog=author.sh \
  $svn_url $git_repository_name
