require 'rubygems'
require 'fileutils'
require File.expand_path('environment.rb', File.dirname(__FILE__))

namespace :db do
  desc 'Create the databases and, if they exist, clear the data in them.'
  task :create do
    Auth.auto_migrate!
    App.auto_migrate!
    Invoice.auto_migrate!
  end
  
  desc 'Upgrade db tables to most recent state.'
  task :upgrade do
    Auth.auto_upgrade!
    App.auto_upgrade!
    Invoice.auto_upgrade!
  end
end

namespace :invoice do
  desc 'Generate the installation-specific config file.'
  task :install do
    template = File.expand_path('tasks/templates/environments.rb', File.dirname(__FILE__))
    config   = File.expand_path('config/environments.rb', File.dirname(__FILE__))

    raise "The environments.rb config already exists!" if File.exists?(config)
    cp template, config, :verbose => true
  end
  
  desc 'Adds a user'
  task :makeuser, :user, :pass do |t, args|
    Auth.create(
      :user => args[:user],
      :pass => args[:pass],
    )
  end
  
  desc 'Gets API'
  task :apikey, :user do |t, args|
    @user = Auth.first(:user => args[:user])
    unless @user.nil?
      puts @user.apikey
    end
  end
  
  desc 'Adds an app'
  task :makeapp, :name, :stub, :start_at do |t, args|
    App.create(
      :name => args[:name],
      :stub => args[:stub],
      :start_at => args[:start_at],
    )
  end
  
  desc 'Adds an invoice'
  task :makeinvoice, :purpose, :app_stub do |t, args|
    inv = Invoice.add_new(args[:purpose], args[:app_stub])
    unless inv.nil?
      puts inv.number
    end
  end
end
