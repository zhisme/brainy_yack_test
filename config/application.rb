require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require "action_cable/engine"
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
Bundler.require(:assets) if Rails.env.in?(%w[development test])
# load pry for dev, test & production console
Bundler.require(:pry) if !Rails.env.production? || defined?(Rails::Console)

module BrainyYackTest
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.app_name = Module.nesting.last.name.downcase

    # config.time_zone = 'UTC'

    config.i18n.default_locale = :en
    config.i18n.available_locales = %i[en]

    # Don't include all helpers to avoid collisions.
    config.action_controller.include_all_helpers = false

    # Don't generate system test files.
    config.generators.system_tests = nil

    # CORS
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins ['142.93.131.30', 'localhost:3001']
        resource '*', headers: :any, methods: :any
      end
    end
  end
end
