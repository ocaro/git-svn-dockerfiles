# git-svn container image

Simple container image to convert from subversion to git using git-svn. The original source code is at [ocaro/git-svn-dockerfiles](https://github.com/ocaro/git-svn-dockerfiles) and the container at [ocaro/git-svn](https://hub.docker.com/r/ocaro/git-svn).

## How to use the image

To run a container where the subversion repository is in `/opt/svn` and the generated git repositories are under `/data`.

```sh
docker run --name $USER-git-svn --rm -it --volume /opt/svn:/opt/svn:ro --volume $PWD:/data ocaro/git-svn ash
```

## Main scripts

These scripts to help converting repositories are under `/usr/local/bin`.

`bashrc.sh` adds git completion and git prompt. Enable by switching to bash then
```
source /usr/local/bin/bashrc.sh
```

`authors.sh` creates a suitable [git-svn](https://git-scm.com/docs/git-svn) `authors-file` from subversion authors using `svn log`. Use if intending to fix author names and emails. 
* Define the environment variable `EMAIL_DOMAIN` to include an email address.

`clone.sh` is a wrapper around `git-svn clone` that also creates local branches and tags, and scrubs the git repository from subversion remnants. Run the script without parameters to see usage help.
* Defaults to the author file `/data/authors.txt`. Define the environment variable `AUTHORS_FILE` to use an another, otherwise generates the git author from the subversion author.
* Define `CLONE_OPTS` to override the default options for `git svn clone` or to set more options.

`clean-history.sh` rewrites the commit history. Creates a `.gitignore`, `.gitattributes`, `README.md` and a `develop` branch. Removes ignored files and directories, and renormalizes text files in all branches. Run the script within the git repository - it does not need parameters. The script relies on [git-filter-branch](https://git-scm.com/docs/git-filter-branch) to rewrite the commit history ignoring files in `.gitignore`, but the image also includes [newren/git-filter-repo](https://github.com/newren/git-filter-repo).

`push.sh` pushes the git repository using the directory name as the name of the remote. Requires `GIT_HOST_URL`.

### Helper scripts

These scripts are used internally by the main scripts.

`author.sh` generates a git author from a subversion author as when using `authors.sh` and when cloning without an authors file.

`gitconfig.sh` configures git settings to commit and push. Requires `AUTHOR_NAME` and `AUTHOR_EMAIL` environment variables.

`gitignore-excludes.sh` exclude some of the ignores. By default, does not ignore the `bin` directory, which Eclipse IDE uses as the default output folder, if it contains shell scripts.

`gitignore.sh` generates a `.gitignore` of well-known junk files and directories for Java development on \*nix and Windows. For example, `gitignore.sh >.gitignore`

`gitattributes.sh` generates a `.gitattributes` to store text files in \*nix format. For example, `gitattributes.sh >.gitattributes`
