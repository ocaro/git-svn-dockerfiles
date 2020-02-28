#!/bin/sh

#
# Push migrated repository.
#
repository=$(git remote get-url origin 2>/dev/null)
if [ $? -ne 0 ]; then
    if [ -z "$GIT_HOST_URL" ]; then
        echo "err: GIT_HOST_URL is not set." >&2
        exit 1
    fi
fi

if [ "$repository" = "" ]; then
    repository_name="$(basename $PWD)"
    case "$GIT_HOST_URL" in
      */)
        repository="$GIT_HOST_URL$repository_name.git"
        ;;
      *) 
        repository="$GIT_HOST_URL/$repository_name.git"
        ;;
    esac
    git remote add origin $repository
fi
git push origin --all
git push origin --tags
