FROM       dfherr/ubuntu:16.04
MAINTAINER Dennis-Florian Herr <herrdeflo@gmail.com>

# additional env as suggested by rbenv ruby-build
RUN sudo apt-get update -qq -y && \
    sudo apt-get install -y \
    bison \
    libssl-dev \
    libyaml-dev \
    libreadline6-dev \
    zlib1g-dev \
    libncurses5-dev \
    libffi-dev \
    libgdbm3 \
    libgdbm-dev; \
    sudo rm -rf /var/lib/apt/lists/*; \
    sudo rm -rf /var/cache/apt/*;

# ruby installation

ARG ruby_version=2.4.1
RUN cd /tmp;                                \
    curl -LO https://github.com/sstephenson/ruby-build/archive/v20170405.tar.gz; \
    sudo chown ubuntu: *.tar.gz;           \
    tar xvzf *.tar.gz; rm -f *.tar.gz;      \
    cd ruby-build*;                         \
    ./bin/ruby-build $ruby_version /usr/local; \
    cd; rm -rf /tmp/ruby-build*

RUN gem install bundler --version 1.15.3 --no-rdoc --no-ri; \
    gem install pry --no-rdoc --no-ri; \
    gem update --system --no-document

ENV PATH .bundle/bin:$PATH
