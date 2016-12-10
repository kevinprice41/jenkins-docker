FROM jenkins
MAINTAINER kevinprice41@gmail.com

USER root

RUN apt-get update -qq && \
    apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables \
    supervisor \
    jq
    
# Install Docker from Docker Inc. repositories.
RUN curl -sSL https://get.docker.com/ | sh

ENV DOCKER_API_VERSION 1.23

#Install AWS CLI
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" \
        && unzip awscli-bundle.zip \
          && ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
