FROM travisci/ci-connie:cs50

# environment
ENV PYTHONDONTWRITEBYTECODE 1

# other packages
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        clang-3.8 \
        debhelper \
        devscripts \
        dh-make \
        lintian \
        openjdk-7-jdk \
        openjdk-7-jre-headless \
		sqlite3 \
        valgrind && \
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.8 380 \
        --slave /usr/bin/clang++ clang++ /usr/bin/clang++-3.8 \
        --slave /usr/bin/clang-check clang-check /usr/bin/clang-check-3.8 \
        --slave /usr/bin/clang-query clang-query /usr/bin/clang-query-3.8 \
        --slave /usr/bin/clang-rename clang-rename /usr/bin/clang-rename-3.8

# Python 3.6
# https://github.com/yyuu/pyenv/blob/master/README.md#installation
# https://github.com/yyuu/pyenv/wiki/Common-build-problems
ENV PYENV_ROOT /opt/pyenv
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        build-essential \
        curl \
        libbz2-dev \
        libncurses5-dev \
        libncursesw5-dev \
        libreadline-dev \
        libsqlite3-dev \
        libssl-dev \
        llvm \
        wget \
        xz-utils \
        zlib1g-dev && \
    wget -P /tmp https://github.com/yyuu/pyenv/archive/master.zip && \
    unzip -d /tmp /tmp/master.zip && \
    rm -f /tmp/master.zip && \
    mv /tmp/pyenv-master /opt/pyenv && \
    /opt/pyenv/bin/pyenv install 3.6.0 && \
    /opt/pyenv/bin/pyenv rehash && \
    /opt/pyenv/bin/pyenv global 3.6.0
ENV PATH "$PYENV_ROOT"/shims:"$PYENV_ROOT"/bin:"$PATH"

# ruby 2.4
ENV RBENV_ROOT /opt/rbenv
RUN apt-get update && \
    apt-get install -y libreadline-dev && \
    wget -P /tmp https://github.com/rbenv/rbenv/archive/master.zip && \
    unzip -d /tmp /tmp/master.zip && \
    rm -f /tmp/master.zip && \
    mv /tmp/rbenv-master /opt/rbenv && \
    chmod a+x /opt/rbenv/bin/rbenv && \
    wget -P /tmp https://github.com/rbenv/ruby-build/archive/master.zip && \
    unzip -d /tmp /tmp/master.zip && \
    rm -f /tmp/master.zip && \
    mkdir /opt/rbenv/plugins && \
    mv /tmp/ruby-build-master /opt/rbenv/plugins/ruby-build && \
    /opt/rbenv/bin/rbenv install 2.4.0 && \
    /opt/rbenv/bin/rbenv rehash && \
    /opt/rbenv/bin/rbenv global 2.4.0
ENV PATH "$RBENV_ROOT"/shims:"$RBENV_ROOT"/bin:"$PATH"

# AWS CLI
RUN pip3 install awscli

# ruby gems
RUN gem install fpm jekyll-asciidoc jekyll-redirect-from pygments.rb

# git-lfs
# https://packagecloud.io/github/git-lfs/install#manual
RUN echo "deb https://packagecloud.io/github/git-lfs/ubuntu/ trusty main" > /etc/apt/sources.list.d/github_git-lfs.list && \
    echo "deb-src https://packagecloud.io/github/git-lfs/ubuntu/ trusty main" >> /etc/apt/sources.list.d/github_git-lfs.list   && \
    curl -L https://packagecloud.io/github/git-lfs/gpgkey | sudo apt-key add - && \
    apt-get update && \
    apt-get install -y git-lfs && \
    git lfs install

# install check50, style50
# TODO
#RUN pip3 install check50 style50

