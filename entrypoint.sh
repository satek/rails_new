rails new $APP_NAME -T -d postgresql $OPTIONS

cp $DOCKERFILES/* $APP_NAME/
cp /root/database.yml $APP_NAME/config/

cd $APP_NAME

bundle add redis --skip-install
bundle add hiredis --skip-install
bundle add sidekiq --skip-install

bundle add rspec-rails --group=development --group=test
bundle add guard-rails --group=development

bundle exec rails g rspec:install
bundle exec guard init rails
