source 'https://rubygems.org'

gem 'rails', '3.2.6'

group :worker do
  gem "resque", "~> 1.20.0"
  gem "docsplit"
  gem "resque-scheduler"
  gem "resque-async-method"
  gem "resque-history"
end

group :orm do
  gem 'pg'
  gem "ancestry"
  gem "carrierwave"
  gem 'amistad'
end

group :authorization do
  gem "devise"
  gem "cancan"
  gem "activeadmin"
end

group :other do
  gem "yettings"
  gem "rmagick"
  gem "unicorn"
  gem "colored"
  gem 'yajl-ruby'
  gem "jbuilder"
  gem "gon"
end

group :views do
  gem "simple_form"
  gem 'haml'
  gem 'haml-rails'
  gem 'drapper'
  gem 'kaminari'
  gem "tabulous"
  gem "wicked"
  gem "sanitize"
  gem "rails_autolink"
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
  gem "bootstrap-wysihtml5-rails"
  gem 'twitter-bootstrap-rails', git: 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
end

group :development, :test do
  gem 'rspec-rails'
  gem "factory_girl_rails"
  gem 'sextant'
  gem 'annotator'
  gem 'rack-livereload' 
  gem "railroady"
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem "guard-spork"
  gem 'guard-brakeman'
  gem 'guard-resque'
  gem 'guard-unicorn'
end

group :test do
  gem "fuubar"
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'resque_spec'
  gem "nyan-cat-formatter"
  gem "spork"
  gem "ruby_gntp"
  gem 'resque_spec'
end
