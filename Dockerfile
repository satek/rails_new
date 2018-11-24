FROM ruby:2.5.3-alpine

RUN apk add alpine-sdk postgresql-dev libpq tzdata nodejs git

WORKDIR /root/workdir

RUN gem install rails -v 5.2.1
RUN gem install rspec-rails -v 3.8.1
RUN gem install guard-rails -v 0.8.1
RUN gem install pg -v 1.1.3

ENV ENTRYPOINT=/usr/local/bin/entrypoint.sh

COPY entrypoint.sh $ENTRYPOINT
RUN chmod a+x $ENTRYPOINT

ENV DOCKERFILES /root/dockerfiles
RUN mkdir -p $DOCKERFILES

COPY Dockerfile.app $DOCKERFILES/Dockerfile
COPY docker-compose.yml $DOCKERFILES
COPY database.yml /root/

CMD $ENTRYPOINT
