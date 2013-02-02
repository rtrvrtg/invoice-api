class App
  include DataMapper::Resource
  property :id,         Serial
  property :name,       Text
  property :stub,       Text
  property :start_at,   Integer,   :default => 1
  
  property :created_at, DateTime, :default => lambda{ |p,s| DateTime.now}
  property :updated_at, DateTime, :default => lambda{ |p,s| DateTime.now}
end
