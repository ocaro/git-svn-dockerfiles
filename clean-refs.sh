#!/bin/bash
#
# Cleanup migrated repository.
#
# https://git-scm.com/book/en/v2/Git-and-Other-Systems-Migrating-to-Git

# Branches: Create local branches.
for b in $(git for-each-ref --format='%(refname:short)' refs/remotes); do git branch $b refs/remotes/$b && git branch -D -r $b; done

# Branches: Delete svn peg revisions (branches with @ in the name).
for p in $(git for-each-ref --format='%(refname:short)' | grep @); do git branch -D $p; done

# Branches: Delete trunk branch (duplicate of master).
git branch -d trunk

# Tags: Create local tags.
for t in $(git for-each-ref --format='%(refname:short)' refs/remotes/tags); do git tag ${t/tags\//} $t && git branch -D -r $t; done
