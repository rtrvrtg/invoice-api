require 'rubygems'
require 'sinatra'
require 'sinatra/jsonp'
require 'sinatra-websocket'
require 'fileutils'

# Pulls in settings and required gems.
require File.expand_path('environment.rb', File.dirname(__FILE__))

# ##### WEBSOCKET ROUTES

set :server, 'thin'
set :sockets, []

# ##### PULLS IN COMPONENTS

#require File.expand_path('app_entity.rb', File.dirname(__FILE__))
#require File.expand_path('invoice_entity.rb', File.dirname(__FILE__))
