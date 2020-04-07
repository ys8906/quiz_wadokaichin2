# frozen_string_literal: true

require 'i18n'
I18n.config.available_locales = :ja
I18n.default_locale = :ja
require 'faker'
Faker::Config.locale # => :ja
Faker::Internet.email # => ".@.com"
