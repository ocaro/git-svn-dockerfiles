#!/bin/sh

#
# Rewrites the commit history to remove ignored junk files.
#

git checkout master
last_updated="$(git log -1 --pretty='format:%cD')"
if [ -z "$last_updated" ]; then
    echo "err: no commits found." >&2
    exit 1
fi

$(dirname $0)/gitconfig.sh

$(dirname $0)/gitattributes.sh >/tmp/.gitattributes
$(dirname $0)/gitignore.sh >/tmp/.gitignore

for b in $(git for-each-ref --format='%(refname:lstrip=2)' refs/heads); do
    git checkout $b
    cp /tmp/.gitattributes .
    cp /tmp/.gitignore .
    $(dirname $0)/gitignore-excludes.sh
    git add .gitignore .gitattributes
    git commit -m "Created .gitignore and .gitattributes"
    git add --renormalize .
    git commit -m "Normalize all the line endings"
done

export FILTER_BRANCH_SQUELCH_WARNING=1
# Do not use --prune-empty as it collapses Maven src/main/java as src.
git filter-branch --tree-filter 'git ls-files -z --ignored --exclude-standard | xargs -0 -r git rm -f --ignore-unmatch' --tag-name-filter cat -- --all

git checkout master
if [ -f README.md ]; then
    git mv README.md README.txt
fi
migrated="$(git show -s --format=%ci HEAD)"
printf "# $(basename $PWD)\n\nMigrated: $migrated\n\nLast updated: $last_updated\n\n" >README.md
git add README.md
git commit -m "Migrated to Git; created README.md"

git checkout -b develop
