FROM ubuntu:14.04

MAINTAINER Sebastian Buza <gore.sebyx@yahoo.com>

# languages
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Setup User
RUN useradd --home /home/sebi -M sebi -K UID_MIN=10000 -K GID_MIN=10000 -s /bin/bash
RUN mkdir /home/sebi
RUN chown sebi:sebi /home/sebi
RUN adduser sebi sudo
RUN echo 'sebi ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo sebi:1234 | /usr/sbin/chpasswd

# make workspace dir
RUN mkdir /home/sebi/workspace

RUN apt-get update
RUN apt-get -y install curl libpq-dev git python-dev openssh-server vim unzip

# setup ssh
RUN echo "PermitRootLogin no\nAllowUsers sebi" >> /etc/ssh/sshd_config
RUN echo "sshd: ALL" >> /etc/hosts.allow
RUN usermod -s /bin/bash sebi

# download kerl
RUN curl https://raw.githubusercontent.com/yrashk/kerl/master/kerl > /usr/bin/kerl
RUN chmod a+x /usr/bin/kerl

USER sebi

#rvm ruby rails
RUN mkdir /home/sebi/ruby_gems/ && mkdir /home/sebi/ruby_gems/2.2

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c 'source ~/.rvm/scripts/rvm'
RUN /bin/bash -l -c 'rvm install 2.2.2 && rvm --default use 2.2.2'
RUN /bin/bash -l -c 'gem install bundler -v 1.10.6 && gem install rails -v 4.2.4'

#nvm node ember
RUN git clone https://github.com/creationix/nvm.git ~/.nvm
RUN echo ". ~/.nvm/nvm.sh" >> ~/.bashrc
RUN /bin/bash -c '. ~/.nvm/nvm.sh && \
    nvm install 4.1.0 && \
    nvm use 4.1.0 && \
    nvm alias default 4.1.0'

#Install ember-cli
RUN /bin/bash -c '. ~/.nvm/nvm.sh && nvm use 4.1.0 && npm install -g bower@1.5.2 ember-cli@1.13.8 phantomjs'

#Install watchman
RUN git clone https://github.com/facebook/watchman.git ~/.watchman
RUN cd ~/.watchman && \
    ./autogen.sh && \
    ./configure && \
    make && \
    sudo make install

RUN sudo echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
RUN sudo sysctl -p

# install erlang
RUN kerl build 18.0 18.0
RUN mkdir ~/.kerl/installs/ && mkdir ~/.kerl/installs/18.0
RUN kerl install 18.0 ~/.kerl/installs/18.0
RUN echo ". ~/.kerl/installs/18.0/activate" >> ~/.bashrc
RUN echo "source ~/.rvm/scripts/rvm" >> ~/.bashrc

# install elixir
RUN \curl -sSL https://raw.githubusercontent.com/taylor/kiex/master/install |  bash -s
RUN echo 'test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"' >> ~/.bashrc
RUN /bin/bash -c 'source ~/.bashrc && kiex install 1.0.5 && kiex default 1.0.5'

# install java
RUN curl -L -s get.jenv.io | bash
RUN /bin/bash -c 'source ~/.bashrc && jenv install java 1.8.0_40 && jenv install maven 3.3.1'

WORKDIR /home/sebi/

#### Ports

# SSH
EXPOSE 22

# Rails
EXPOSE 3000

# Ember
EXPOSE 4200
EXPOSE 35729
EXPOSE 7357

CMD /bin/bash --login