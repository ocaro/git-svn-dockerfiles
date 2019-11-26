#!/bin/sh
#
# Push migrated repository.
#
project="https://fleetcor-ocaro@bitbucket.org/fleetcorcp"
git remote add origin $project:$repository.git
git checkout master
git checkout -b develop
git push --mirror
