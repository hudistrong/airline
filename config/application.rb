require_relative 'boot'

require 'rails/all'
require "active_job/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HudiAirlines
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

  	config.autoload_paths += %W(
        #{config.root}/lib
    )
    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]

  	config.active_record.default_timezone = :local
  	config.time_zone = 'Beijing'
    # config.i18n.default_locale = "zh-CN"
    config.encoding = "utf-8"
    config.active_job.queue_adapter = :sidekiq
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
