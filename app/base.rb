require 'sinatra/base'
require 'sinatra/jsonp'
require 'sass'
require './lib/auth'

# ##### BASE APP

module Base
  def self.registered(app)
    app.helpers Sinatra::APIKeyAuth

    app.get "/" do
      enforce_valid_key!
      'hi'
    end
    
    app.get '/styles' do
      content_type 'text/css', :charset => 'utf-8'
      scss File.open('public/styles.scss').read
    end
  end
end
