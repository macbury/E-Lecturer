source 'https://rubygems.org'

gem 'rails', '3.2.5'

group :orm do
  gem 'pg'
  gem "ancestry"
  gem "carrierwave"
  gem "rmagick"
end

group :authorization do
  gem "devise"
  gem "cancan"
  gem "activeadmin"
end

group :other do
  gem "yettings"

  gem "thin"
  gem "colored"
end

group :views do
  gem "simple_form"
  gem 'haml'
  gem 'haml-rails'
  gem 'drapper'
  gem 'kaminari'
  gem "tabulous"
  gem "wicked"
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', platforms: :ruby
  gem 'compass-rails'
  gem 'uglifier', '>= 1.0.3'
  gem 'quiet_assets'
  gem 'chosen-rails'
  gem 'less-rails-fontawesome'
  gem 'twitter-bootstrap-rails', git: 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
end

group :development, :test do
  gem 'rspec-rails'
  gem "factory_girl_rails"
  gem 'sextant'
  gem 'annotator'
  gem 'rack-livereload' 
end

group "test" do
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem "nyan-cat-formatter"
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem "guard-spork"
  gem "spork"
  gem 'capybara'
  gem "ruby_gntp"
end
