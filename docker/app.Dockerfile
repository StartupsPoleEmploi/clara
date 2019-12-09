FROM ubuntu:bionic

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Utilities
RUN apt-get update \
    && apt-get install -y --no-install-recommends wget git sudo vim telnet iputils-ping ssh openssh-server cron

# executable JS is required
RUN cd ~ \
    && wget deb.nodesource.com/setup_10.x -O nodesource_setup.sh \
    && bash nodesource_setup.sh\
    && apt install nodejs\
    && nodejs -v

# See https://github.com/phusion/passenger-docker/issues/195#issuecomment-321868848
RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get install -y tzdata

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
RUN wget https://raw.githubusercontent.com/StartupsPoleEmploi/clara/20.37.0/Gemfile -O Gemfile
RUN wget https://raw.githubusercontent.com/StartupsPoleEmploi/clara/20.37.0/Gemfile.lock -O Gemfile.lock
RUN bundle install --without development test undefined 

# Launch cron jobs (for db dump everyday)
CMD service cron start && sleep infinity
