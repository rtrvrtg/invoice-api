require 'sinatra/base'
require 'sinatra/jsonp'
require 'sinatra/respond_to'
require './lib/auth'

# ##### BASE APP

class Apps < Sinatra::Base
  helpers Sinatra::APIKeyAuth
  helpers Sinatra::Jsonp
  register Sinatra::RespondTo
  
  get "/apps/index" do
    enforce_valid_key!
    @result = App.all
    
    respond_to do |r|
      r.json  { jsonp @result }
    end
  end
  
  get "/app/:app_stub" do
    enforce_valid_key!
    @result = App.first(:stub => params[:app_stub])
    
    respond_to do |r|
      r.json  { jsonp @result }
    end
  end
  
  post '/app/new' do
    enforce_valid_key!
    
    app = App.new
    app.name = params[:name]
    app.stub = params[:stub]
    if params.has_key? "start_at"
      app.start_at = params[:start_at]
    end
    
    app.save
    
    respond_to do |r|
      r.json  { jsonp app }
    end
  end
end
