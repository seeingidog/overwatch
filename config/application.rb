require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "action_controller/railtie"
require "action_mailer/railtie"

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Overwatch
  class Application < Rails::Application
    config.generators do |g|
      g.template_engine :haml
      g.test_framework :rspec, :fixture => true
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
      g.orm :datamapper
    end

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable the asset pipeline
    config.assets.enabled = true
    
    SimpleForm.wrapper_tag = :p
    
  end
end
