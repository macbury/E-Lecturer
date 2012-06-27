require 'rubygems'
require 'spork'

ENV["RAILS_ENV"] ||= 'test'

Spork.prefork do
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require "cancan/matchers"
  require 'carrierwave/test/matchers'
  
  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }


  RSpec.configure do |config|
    config.mock_with :rspec

    config.include FactoryGirl::Syntax::Methods
    config.include Devise::TestHelpers, type: :controller
    config.include SignHelper,          type: :controller
    config.include UserHelper
    config.include StreamHelper
    
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    config.infer_base_class_for_anonymous_controllers = false
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true

    config.use_transactional_fixtures = false
  
    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
    end

    config.before(:each) do
      Rails.logger.info "Starting db clean".bold.blue
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
      Rails.logger.info "Cleaning db".bold.blue
    end
  end

end

Spork.each_run do
  FactoryGirl.reload
end

