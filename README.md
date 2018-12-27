# How to use it

To generate a new app named myapp run:
```sh
docker run -e "APP_NAME=myapp" -v `pwd`:/root/workdir satek/rails_new
```

This will simply create a new rails app in myapp folder, same as running "rails new" locally would. The newly created directory will be owned by root. You probably want to change that by running `sudo chown -R youruser:youruser myapp`.

In addition the image will add rspec, guard and set up Docker related files.

`docker-compose.yml` sets up Postgres and Redis services and `database.yml` is modified to make use of the Postgres service.


The idea is to be able to quickly generate an app and be able to run it immediately with the database set up.
When the app is generated `cd` into the folder and run `docker-compose up`. Now you should be able to send requests to your web app at http://localhost:3000 and run other rails commands from another terminal or tmux pane.

For example, `docker-compose run web rails db:setup` to set up the database. `docker-compose run web rails c` to start a Rails console.

`web` in the commands above is a service defined in `docker-compose.yml`. You can, of course, add additional services such as `sidekiq` to the same file.
