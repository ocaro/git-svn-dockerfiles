. /usr/local/bin/git-completion.bash
. /usr/local/bin/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\w$(__git_ps1 " (%s)")\$ '
