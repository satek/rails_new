# How to use it

To generate a new app named myapp run:
```sh
docker run -it -e "APP_NAME=myapp" -v `pwd`:/root/workdir satek/rails_new
```

This will simply create a new rails app in myapp folder, same as running "rails new" locally would.
In addition it will add rspec, guard and set up the Docker related files.

`docker-compose.yml` sets up Postgres and Redis services and `database.yml` is modified to make use of the Postgres service.


The idea is to be able to quickly generate an app and be able to run it immediately with the database set up.
When the app is generated `cd` into the folder and run `docker-compose up`. Now you can run other rails commands from another terminal or tmux pane.
E.g. `docker-compose run web rails db:setup` to set up the database. `docker-compose run web rails c` to start a Rails console.

`web` in the commands above is a service defined in `docker-compose.yml`. You can of course add additional services such as `sidekiq` to the same file.
