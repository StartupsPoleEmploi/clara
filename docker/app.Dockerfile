FROM ruby:2.6.0

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Utilities
RUN apt-get update && apt-get install -y --no-install-recommends curl wget git sudo vim telnet iputils-ping ssh openssh-server

# executable JS is required
RUN cd ~\
    && curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh\
    && bash nodesource_setup.sh\
    && apt install nodejs\
    && nodejs -v

# For Yarn
RUN wget https://github.com/yarnpkg/yarn/releases/download/v1.19.1/yarn_1.19.1_all.deb\
    && dpkg -i yarn_1.19.1_all.deb


# See https://github.com/phusion/passenger-docker/issues/195#issuecomment-321868848
RUN apt-get install -y tzdata

# for postgres
RUN apt-get install -y libpq-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# For local tunneling
RUN mkdir /root/.ssh/
RUN echo 'NoHostAuthenticationForLocalhost yes' > /root/.ssh/config

RUN echo "root:root" | chpasswd
RUN mkdir -p /home/clara
WORKDIR /home/clara

RUN echo "service ssh restart" > ./allow_local_tunnel.sh
RUN echo "yes y | ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ''" >> ./allow_local_tunnel.sh
RUN echo "cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys" >> ./allow_local_tunnel.sh
RUN echo "chmod og-wx ~/.ssh/authorized_keys" >> ./allow_local_tunnel.sh

# Pre-load deployment gems
RUN curl https://raw.githubusercontent.com/StartupsPoleEmploi/clara/20.37.0/Gemfile -o Gemfile
RUN curl https://raw.githubusercontent.com/StartupsPoleEmploi/clara/20.37.0/Gemfile.lock -o Gemfile.lock
RUN bundle install --without development test undefined 

# wait...
CMD sleep infinity

