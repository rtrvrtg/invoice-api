require 'sinatra/base'
require 'sinatra/jsonp'
require './lib/auth'

# ##### BASE APP

class Base < Sinatra::Base
  helpers Sinatra::APIKeyAuth

  get "/" do
    enforce_valid_key!
    'hi'
  end
end
