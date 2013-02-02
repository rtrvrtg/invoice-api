#
# Change these depending on your settings.
# (This example setup assumes a SQLite dev/test and a Heroku production.)
#

configure do
end

# Default to the below settings; replace if necessary:

configure :development do
  require 'sqlite3'
  set :database_url, "sqlite3://#{File.expand_path('../db/development.sqlite3', File.dirname(__FILE__))}"
end

configure :test do
  require 'sqlite3'
  set :database_url, "sqlite3://#{File.expand_path('../db/test.sqlite3', File.dirname(__FILE__))}"
end

# Not usable by Heroku (can't use files not checked in), but useful
# if set up anywhere else.
configure :production do
  set :database_url, ENV['DATABASE_URL']
end
