require 'sinatra/base'
require 'sinatra/jsonp'
require './lib/auth'

# ##### BASE APP

module Base
  def self.registered(app)
    app.helpers Sinatra::APIKeyAuth

    app.get "/" do
      enforce_valid_key!
      'hi'
    end
  end
end
