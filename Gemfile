source 'http://rubygems.org'

gem 'sinatra'
gem 'rake'

gem 'data_mapper'
gem 'dm-types'
gem 'dm-ar-finders'

group :development do
  gem 'dm-sqlite-adapter'
  gem 'sqlite3'
end

group :production do
  gem 'dm-postgres-adapter'
end

gem 'xml-simple'
gem 'activeresource', '3.0.10'

gem 'haml'

gem 'sinatra-respond_to', :require => 'sinatra/respond_to',
                          :git => 'git://github.com/cehoffman/sinatra-respond_to.git',
                          :ref => '0b8892eb188fb7ba9d1'
gem 'sinatra-jsonp', :require => 'sinatra/jsonp'
gem 'rack_csrf'
gem 'thin'

gem 'activesupport'

group :development, :test do
  gem 'rspec'
  gem 'capybara'
  gem "factory_girl", "~> 3.0"
  gem 'ffaker'
  gem 'thin'
end
