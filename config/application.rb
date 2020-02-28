require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Quiz
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Asset pipeline -> webpackerに伴い、アセットの自動生成を停止
    config.generators do |g|
      g.assets false
    end

    # Timezones
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local 

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Autoload ./lib
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    # Below did not work (somehow)
    # config.autoload_paths += %W(#{config.root}/lib)
    # config.paths.add 'lib', eager_load: true

    config.i18n.default_locale = :ja

  end
end
