require 'sinatra/base'
require 'sinatra/jsonp'
require 'sinatra/respond_to'
require './lib/auth'

# ##### BASE APP

module Apps
  def self.registered(app)
    app.helpers Sinatra::APIKeyAuth
    app.helpers Sinatra::Jsonp

    app.get "/apps/index" do
      enforce_valid_key!
      @result = App.all

      respond_to do |r|
        r.json  { jsonp @result }
      end
    end

    app.get "/app/:app_stub" do
      enforce_valid_key!
      @result = App.first(:stub => params[:app_stub])

      respond_to do |r|
        r.json  { jsonp @result }
      end
    end

    app.post '/app/new' do
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
end
