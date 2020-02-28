# git-svn container image

Simple container image to convert from subversion to git using git-svn. The original source code is at [orlandocaro/git-svn-dockerfiles](https://github.com/orlandocaro/git-svn-dockerfiles) and the container at [orlandocaro/git-svn](https://hub.docker.com/r/orlandocaro/git-svn).

## How to use the image

To run a container where the subversion repository is in `/opt/svn` and the generated git repositories are under `/data`.

```sh
docker run --name $USER-git-svn --rm -it --volume /opt/svn:/opt/svn:ro --volume $PWD:/data orlandocaro/git-svn ash
```

## Scripts available

These scripts to help converting repositories are under `/usr/local/bin`.

`authors.sh` generates a [git-svn](https://git-scm.com/docs/git-svn) `authors file` from subversion authors using `svn log`. Use this script if intending to fix authors names and emails, then define `AUTHORS_FILE` with the full path to the git authors-file name.

`clone.sh` is a wrapper around `git-svn clone`. After cloning, creates local branches, tags, and scrubs the git repository from subversion remnants. Define the environment variable `AUTHORS_FILE` to use it as `--authors-file`, and the environment variable `CLONE_OPTS` for more options. If an authors file is not found, uses the svn author as the git author name and the email if the environment variable `EMAIL_DOMAIN` is set. Define `CLONE_OPTS` to override the default options for `git svn clone` or to set more options.

`clean-history.sh` rewrites the commit history. Creates a `.gitignore`, `.gitattributes`, `README.md` and a `develop` branch. Removes ignored files and directories, and renormalizes text files in all branches.

`push.sh` pushes the git repository using the directory name as the name of the remote. Requires `GIT_HOST_URL`.

### Helpers

`author.sh` generates output compliant with a git author. Define the environment variable `EMAIL_DOMAIN` to include an email address.
* See `git-svn clone --author-prog`.

`gitconfig.sh` configures git settings to commit and push. Requires `AUTHOR_NAME` and `AUTHOR_EMAIL` environment variables.

`gitattributes.sh` generates a `.gitattributes` to store text files in *nix format.

`gitignore.sh` generates a `.gitignore` of well-known junk files and directories for Java development on *nix and Windows.

`gitignore-excludes.sh` exclude some of the ignores. By default, does not ignore the `bin` directory, which Eclipse IDE uses as the default output folder, if it contains shell scripts.

### About rewrites

`clean-history.sh` relies on [git-filter-branch](https://git-scm.com/docs/git-filter-branch) to rewrite the commit history ignoring files in `.gitignore`. The image also includes [newren/git-filter-repo](https://github.com/newren/git-filter-repo).
