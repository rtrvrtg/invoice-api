require 'digest/sha1'
require 'dm-types'

class Auth
  include DataMapper::Resource
  property :id,       Serial
  property :user,     Text,       :required => true,    :unique => true
  property :pass,     BCryptHash, :reader => :private,  :required => true, :unique => true
  property :apikey,   APIKey,     :writer => :private,  :unique => true
  
  def self.auth_user(user, pass)
    Auth.first(:user => user, :pass => pass)
  end
  
  def self.auth_api(apikey)
    Auth.first(:apikey => apikey)
  end
  
end
