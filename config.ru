# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

if ENV['RACK_ENV'] != 'production'
  require 'rack-livereload' 
  use Rack::LiveReload 
end
run Electurer::Application
