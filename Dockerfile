FROM debian:stable-slim
LABEL author="Orlando Caro <ocaro@users.noreply.github.com>"
RUN apt-get update && apt-get install -y \
        bash-completion \
        curl \
        git \
        git-svn \
        nano \
        python3-minimal \
        python3-pip \
        subversion \
        vim \
    && apt-get clean

RUN pip3 install --no-cache --upgrade pip setuptools git-filter-repo
ENV CURL_OPTS="--insecure --connect-timeout 3 --silent --show-error"

RUN cd /usr/local/bin \
    && curl $CURL_OPTS -O https://raw.githubusercontent.com/newren/git-filter-repo/main/contrib/filter-repo-demos/clean-ignore \
    && curl $CURL_OPTS -O https://raw.githubusercontent.com/newren/git-filter-repo/main/contrib/filter-repo-demos/insert-beginning \
    && curl $CURL_OPTS -O https://raw.githubusercontent.com/newren/git-filter-repo/main/contrib/filter-repo-demos/lint-history \
    && chmod 755 clean-ignore insert-beginning lint-history \
    && curl -O https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash \
    && curl -O https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
ADD *.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/*.sh

# Git completion and prompt - root
RUN touch $HOME/.bashrc \
    && cat /usr/local/bin/bashrc.sh >> $HOME/.bashrc

RUN useradd --create-home gituser
USER gituser

# Git completion and prompt - user
RUN touch $HOME/.bashrc \
    && cat /usr/local/bin/bashrc.sh >> $HOME/.bashrc

WORKDIR /data
