require 'sinatra' unless defined?(Sinatra)
require 'active_resource'
require 'haml'
require 'data_mapper'
require 'dm-ar-finders'
require 'open-uri'
require 'cgi'
require 'json'
require 'active_support/all'

# Load plugins (and step around /vendor/bundler).
require "#{File.dirname(__FILE__)}/vendor/sinatra_rack.rb"
Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].each { |f| require f }
Dir["#{File.dirname(__FILE__)}/models/**/*.rb"].each { |f| require f }
#Dir["#{File.dirname(__FILE__)}/vendor/{gems,plugins}/**/*.rb"].each { |f| load(f) }

# Per-environment config. Added condition just in case rake hasnt created it yet
env_path = File.expand_path('config/environments.rb', File.dirname(__FILE__))
require env_path if File.exists?(env_path)

# Global config
configure do
  enable :sessions
  set :views, File.dirname(__FILE__) + "/views"

  # Fallbacks
  set :database_url, ENV['DATABASE_URL'] unless settings.respond_to?(:database_url)
end

# Stop haml being a dick.
Haml::Template.options[:attr_wrapper] = '"'

# Model setup
unless settings.database_url.blank?
  DataMapper.finalize
  DataMapper.setup(:default, settings.database_url)
end

