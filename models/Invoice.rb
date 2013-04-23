require 'digest/sha1'
require 'dm-types'

class Invoice
  include DataMapper::Resource
  property :id,           Serial
  property :app_id,       Integer,    :required => true
  property :invoice_id,   Integer
  property :purpose,      String,     :required => true
  property :number,       String,     :unique => true
  
  property :created_at, DateTime, :default => lambda{ |p,s| DateTime.now}
  property :updated_at, DateTime, :default => lambda{ |p,s| DateTime.now}
  
  before :save do
    starts_at = 1
    
    @app = self.app
    if @app.start_at >= starts_at
      starts_at = @app.start_at
    end
    
    last = Invoice.find_last_by_year(@app.stub)
    unless last.nil?
      if last.invoice_id >= starts_at
        starts_at = last.invoice_id + 1
      end
    end
    
    self.invoice_id = starts_at
    
    self.number = [
      @app.stub,
      self.created_at.year.to_s,
      self.invoice_id.to_s.rjust(4, '0')
    ].join('-')
  end
  
  def app
    App.first(:id => self.app_id)
  end
  
  def self.find_last_by_year(stub, year = Date.today.year)
    @app = App.first(:stub => stub)
    
    date_start = Date.new(year, 1, 1)
    date_end = Date.new(year, 12, 31)
    
    Invoice.first(
      :app_id => @app.id,
      :created_at => date_start..date_end,
      :order => [ :created_at.desc ]
    )
  end
  
  def self.add_new(purpose, app_stub)
    @app = App.first(:stub => app_stub)
    
    if @app.nil?
      logger.info "no app found for #{app_stub}"
      return nil
    end
    
    inv = Invoice.new
    inv.attributes = { :purpose => purpose, :app_id => @app.id }
    saved = inv.save
    
    if saved
      return inv
    else
      logger.info "Failed validation for #{app_stub}, #{purpose}"
      inv.errors.each do |e|
        logger.info e
      end
      return nil
    end
  end
  
end
