require_relative 'boot'

require 'rails/all'

require 'carrierwave'
require 'carrierwave/orm/activerecord'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Portfolios
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :fr

    config.middleware.use Rack::Cors do
    allow do
      origins '*'
      resource '*',
        :headers => :any,
        :expose  => ['access-token', 'expiry', 'token-type', 'uid', 'client'],
        :methods => [:get, :post, :options, :delete, :put]
    end
   end
  end
end
