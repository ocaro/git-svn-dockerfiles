#!/bin/sh

. $(dirname $0)/functions.sh

if [ -z "$HOME" ]; then
    err "HOME environment variable is not set."
    exit 1
fi

if [ -z "$USER" ]; then
    err "USER environment variable is not set."
    exit 1
fi

usage() {
    echo "Usage: $(basename $0) -s <svn repository url> -g <git repository name> -a <authors file>\nClones a repository from svn to git."
    exit 1
}

if [ has_longopts = 'longopts' ]; then
    args=$(getopt --name "$0" --options s:g:a: --longoptions svn-url:,git-name:,authors-file: -- $*)
else
    args=$(getopt s:g:a: $*)
fi
if [ $? -ne 0 ]; then
    usage
    exit 2
fi
set -- $args

while :; do
    case "$1" in
    -s|--svn-url)
        svn_url="$2"
        shift; shift
        ;;
    -g|--git-name)
        git_name="$2"
        shift; shift
        ;;
    -a|--authors-file)
        authors_file="$2"
        shift; shift
        ;;
    --)
        shift
        break
        ;;
    *)
        err "argument not supported: $1"
        usage
        ;;
    esac
done
if [ -z "$svn_url" ] || [ -z "$git_name" ]; then
    err "missing arguments"
    usage
fi
debug "svn_url is '$svn_url'"
debug "git_name is '$git_name'"

# Check if specified alternate authors file exists.
if [ ! -z "$authors_file" ] && [ ! -f "$authors_file" ]; then
    err "git authors file not found."
    exit 1
fi
# Check if default authors file exists.
if [ -z "$authors_file" ] && [ -f "/data/authors.txt" ]; then
    authors_file="/data/authors.txt"
fi
# Check if default authors file exists in HOME.
if [ -z "$authors_file" ] && [ -f "$HOME/authors.txt" ]; then
    authors_file="$HOME/authors.txt"
fi

# Use default clone options.
if [ -z "$CLONE_OPTS" ]; then
    CLONE_OPTS="--username=$USER --no-metadata --tags=/tags --branches=/branches --branches=/branch"
fi
# Use trunk directory if found.
trunk="$(svn ls $svn_url | grep -i 'trunk/' | tr -d '/')"
if [ -z "$trunk" ]; then
    warn "trunk-less svn repository."
    CLONE_OPTS="$CLONE_OPTS --trunk=/"
else
    CLONE_OPTS="$CLONE_OPTS --trunk=/$trunk"
fi
# Use authors file if available.
if [ -f "$authors_file" ]; then
    CLONE_OPTS="$CLONE_OPTS --authors-file=$authors_file"
fi
# Use svn author if git author not found in authors file.
CLONE_OPTS="$CLONE_OPTS --authors-prog=$(dirname $0)/author.sh"

info "Cloning repository."
info "Using CLONE_OPTS=$CLONE_OPTS"
git svn clone $CLONE_OPTS $svn_url $git_name
onerror_exit
info "Clone completed."

#
# Cleanup cloned repository.
# https://git-scm.com/book/en/v2/Git-and-Other-Systems-Migrating-to-Git
#
info "Cleaning refs."
cd $git_name

# Tags
info "Create local tags."
for t in $(git for-each-ref --format='%(refname:short)' refs/remotes/tags); do git tag ${t/tags\//} $t && git branch -D -r $t; done
onerror_exit

# Branches
info "Create local branches."
for b in $(git for-each-ref --format='%(refname:short)' refs/remotes); do git branch $(basename $b) refs/remotes/$b && git branch -D -r $b; done
onerror_exit

# Branches
info "Delete svn peg revisions (branches with @ in the name)."
for p in $(git for-each-ref --format='%(refname:short)' | grep @); do git branch -D $p; done
onerror_exit

# Branches
info "Delete trunk branch (duplicates master)."
git branch -d trunk
onerror_exit

info "Clean completed."
