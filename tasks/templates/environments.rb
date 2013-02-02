#
# Change these depending on your settings.
# (This example setup assumes a SQLite dev and a Heroku production.)
#

configure do
end

# Default to the below settings; replace if necessary:

configure :development do
  #require 'sqlite3'
  #set :database_url, "sqlite3://#{File.expand_path('../db/development.sqlite3', File.dirname(__FILE__))}"
end

configure :production do
  #set :database_url, ENV['DATABASE_URL'] # eg. for Heroku
end
