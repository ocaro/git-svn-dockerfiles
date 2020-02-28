FROM debian:10-slim
LABEL author="Orlando Caro <orlandocaro@users.noreply.github.com>"
RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get install -y git git-svn subversion curl bash findutils vim nano python3
ENV CURL_OPTS="--insecure --connect-timeout 3 --silent --show-error"
RUN cd $(git --exec-path) \
    && curl $CURL_OPTS -O https://raw.githubusercontent.com/newren/git-filter-repo/master/git-filter-repo \
    && chmod 755 git-filter-repo
ENV PYTHONPATH="/usr/local/lib/python3"
RUN mkdir $PYTHONPATH \
    && cd $PYTHONPATH \
    && ln -s $(git --exec-path)/git-filter-repo git_filter_repo.py
RUN cd /usr/local/bin \
    && curl $CURL_OPTS -O https://raw.githubusercontent.com/newren/git-filter-repo/master/contrib/filter-repo-demos/clean-ignore \
    && chmod 755 clean-ignore
ADD *.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/*.sh
RUN useradd --create-home --home-dir /data gituser
USER gituser
WORKDIR /data
