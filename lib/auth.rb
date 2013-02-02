require 'sinatra/base'

module Sinatra
  module APIKeyAuth
    def enforce_valid_key!
      error 401 unless valid_key? == true
    end
    
    def valid_key?
      test = Auth.auth_api(params[:key])
      return !test.nil?
    end
  end

  helpers APIKeyAuth
end