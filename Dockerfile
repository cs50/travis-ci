FROM travisci/ci-connie:cs50

# environment
ENV PYTHONDONTWRITEBYTECODE 1

RUN apt-get update && \
    apt-get install -y \
        clang-3.8 \
        python3-pip \
        ruby-dev \
        valgrind && \
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.8 380 \
        --slave /usr/bin/clang++ clang++ /usr/bin/clang++-3.8 \
        --slave /usr/bin/clang-check clang-check /usr/bin/clang-check-3.8 \
        --slave /usr/bin/clang-query clang-query /usr/bin/clang-query-3.8 \
        --slave /usr/bin/clang-rename clang-rename /usr/bin/clang-rename-3.8

# install python packages
RUN pip3 install awscli cs50

# install submit50
RUN git clone -b check50 https://github.com/cs50/submit50.git && \
    pip3 install ./submit50/

# install check50
RUN git clone -b develop https://github.com/cs50/check50.git && \
    pip3 install ./check50/

# install libcs50
RUN sudo add-apt-repository ppa:cs50/ppa && \
    sudo apt-get update && \
    sudo apt-get install -y libcs50

# FPM
RUN gem install fpm

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
