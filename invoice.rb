require 'rubygems'
require 'sinatra/base'
require 'sinatra/jsonp'
require 'sinatra-websocket'
require 'fileutils'

# Pulls in settings and required gems.
require File.expand_path('environment.rb', File.dirname(__FILE__))

# Load all apps
Dir[File.expand_path('app/*.rb', File.dirname(__FILE__))].each {|f| require f }

# ##### APPLICATION

class InvoicesApp < Sinatra::Base
  register Base
  register Apps
  register Invoices
end
