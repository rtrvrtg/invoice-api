require 'logger'
require 'sinatra/base'
require 'sinatra/jsonp'
require 'sinatra/respond_to'
require './lib/auth'

# ##### INVOICE APP

module Invoices
  def self.registered(app)
    app.helpers Sinatra::APIKeyAuth
    app.helpers Sinatra::Jsonp
    app.register Sinatra::RespondTo

    app.get "/invoices/index" do
      enforce_valid_key!
      @result = Invoice.all

      respond_to do |r|
        r.json  { jsonp @result }
      end
    end

    app.get "/invoices/:stub-:year" do
      enforce_valid_key!

      @date_start = Date.new(params[:year].to_i, 1, 1)
      @date_end = Date.new(params[:year].to_i, 12, 31)
      
      @app = App.first(:stub => params[:stub])
      
      if @app.nil?
        halt 400
      end

      @result = Invoice.all(
        :app_id => @app.id,
        :created_at => @date_start..@date_end
      )

      respond_to do |r|
        r.json  { jsonp @result }
      end
    end

    app.get "/invoice/:stub-:year-:invoice_id" do
      enforce_valid_key!

      @date_start = Date.new(params[:year].to_i, 1, 1)
      @date_end = Date.new(params[:year].to_i, 12, 31)
      
      @app = App.first(:stub => params[:stub])
      
      if @app.nil?
        halt 400
      end

      @result = Invoice.first(
        :invoice_id => params[:invoice_id].to_i,
        :app_id => @app.id,
        :created_at => @date_start..@date_end
      )

      respond_to do |r|
        r.json  { jsonp @result }
        r.html  { haml :invoice_tpl, :locals => { :inv => @result } }
      end
    end

    app.post '/invoice/new' do
      enforce_valid_key!
      logger = Logger.new(STDOUT)
      logger.info "trying to generate new invoice for #{params[:purpose]}, #{params[:app_stub]}"

      begin
        inv = Invoice.add_new(params[:purpose], params[:app_stub])
      rescue StandardError => e
        logger.error e.class.to_s
        logger.error e.message
        e.backtrace.each do |l|
          logger.error l
        end
        halt 500
      end

      if inv.nil?
        logger.info "halting now because no invoice was found"
        halt 500
      end

      respond_to do |r|
        r.json  { jsonp inv }
      end
    end

  end
end
