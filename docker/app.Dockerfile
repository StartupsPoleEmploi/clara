# See https://stackoverflow.com/a/47642594/2595513
FROM ubuntu:16.04

ENV RBENV_ROOT=/usr/local/rbenv
ENV PATH=$RBENV_ROOT/bin:$RBENV_ROOT/shims:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV RUBY_VERSION=2.6.0

# Prerequisites
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake curl git zlib1g-dev \
    libssl-dev libreadline-dev \
    libyaml-dev libxml2-dev \
    libxslt-dev libsqlite3-dev \
    python-dev libxml2-dev \
    libxslt-dev groff zip \
    pkg-config ca-certificates \
    && apt-get clean


# Install rbenv
RUN git clone https://github.com/rbenv/rbenv.git /usr/local/rbenv \
    && echo '# rbenv setup' > /etc/profile.d/rbenv.sh \
    && echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh \
    && echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh \
    && echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh \
    && chmod +x /etc/profile.d/rbenv.sh


# install ruby-build
RUN mkdir /usr/local/rbenv/plugins \
    && git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build \
    && /usr/local/rbenv/plugins/ruby-build/install.sh \
    && rbenv install ${RUBY_VERSION} \
    && rbenv global ${RUBY_VERSION} \
    && gem install bundler \
    && rbenv rehash

# install Rails
# RUN gem install rails -v ${RAILS_VERSION}

# executable JS is required
RUN cd ~\
    && curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh\
    && bash nodesource_setup.sh\
    && apt install nodejs\
    && nodejs -v

# Utilities
RUN apt-get -y install sudo vim telnet iputils-ping language-pack-fr ssh openssh-server

# See https://github.com/phusion/passenger-docker/issues/195#issuecomment-321868848
RUN apt-get install -y tzdata

# for postgres
RUN apt-get install -y libpq-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# For local tunneling
RUN mkdir /root/.ssh/
RUN echo 'NoHostAuthenticationForLocalhost yes' > /root/.ssh/config

# will be able to install deployment gems only
RUN gem install bundle-only

RUN echo "root:root" | chpasswd
RUN mkdir -p /home/clara
WORKDIR /home/clara

RUN echo "service ssh restart" > ./allow_local_tunnel.sh
RUN echo "yes y | ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ''" >> ./allow_local_tunnel.sh
RUN echo "cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys" >> ./allow_local_tunnel.sh
RUN echo "chmod og-wx ~/.ssh/authorized_keys" >> ./allow_local_tunnel.sh

RUN echo "cd /var/git/ara.git" > ./deploy.sh
RUN echo "bundle exec mina production2 setup" >> ./deploy.sh
RUN echo "bundle exec mina production2 deploy" >> ./deploy.sh

# Pre-load deployment gems
RUN curl https://raw.githubusercontent.com/StartupsPoleEmploi/clara/20.29.0/Gemfile -o Gemfile
RUN curl https://raw.githubusercontent.com/StartupsPoleEmploi/clara/20.29.0/Gemfile.lock -o Gemfile.lock
RUN bundle install --without development test undefined 

# wait...
CMD sleep infinity

