FROM ruby:2.5.3-alpine as builder

RUN apk add alpine-sdk postgresql-dev libpq tzdata nodejs

ENV BUILD_DIR /root/build

RUN mkdir -p $BUILD_DIR
WORKDIR $BUILD_DIR
COPY Gemfile $BUILD_DIR/
COPY Gemfile.lock $BUILD_DIR/

RUN gem update --system --no-doc
RUN gem install bundler --no-ri --no-rdoc
RUN bundle install


FROM ruby:2.5.3-alpine

RUN apk add libpq tzdata nodejs

ENV APP_DIR=/root/app
RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR

RUN gem update --system --no-doc

COPY . $APP_HOME
COPY --from=builder $BUILD_DIR $APP_HOME/
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /root/.bundle /root/.bundle

ENTRYPOINT ["bundle", "exec"]

CMD sh
