FROM kali-linux-docker:latest

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y openssh-server python git vim tmux tor CURL
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN apt-get autoclean
RUN apt-get install -y build-essential zlib1g zlib1g-dev libreadline6 libreadline6-dev libssl-dev
RUN curl -L https://get.rvm.io | bash -s -- --ignore-dotfiles --autolibs=0 --ruby
RUN touch ~/.gemrc
RUN echo 'gem: -–no-rdoc --no-ri' >> ~/.gemrc
RUN rvm install ruby-2.5.2
RUN rvm use 2.5.2 --default
RUN gem install bundler

## install the prerequisite patches here so that rvm will install under non-root account.
#RUN apt-get install -y curl patch gawk g++ gcc make libc6-dev patch libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev
#RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
#RUN /bin/bash -l -c "curl -L get.rvm.io | bash -s stable --rails"
#RUN /bin/bash -l -c "rvm install 2.1"
#RUN /bin/bash -l -c "echo 'gem: --no-ri --no-rdoc' > ~/.gemrc"
#RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"