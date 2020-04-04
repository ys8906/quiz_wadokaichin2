source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise', '4.7.1'
gem 'seed-fu', '~> 2.3'
gem 'twitter', '~> 6.2'
gem 'whenever', '~> 1.0', require: false
gem 'slack-notifier', '2.3.2'
gem 'aws-sdk', '~> 3'
gem 'kaminari', '~> 1.2'
gem 'better_errors', '~> 2.6'
gem 'binding_of_caller', '~> 0.8.0'
gem 'breadcrumbs_on_rails', '~> 4.0'
gem 'breadcrumbs_on_rails-json_ld', '~> 1.0'
gem 'sentry-raven', '~> 3.0'

# Social login
gem 'omniauth', '~> 1.9'
gem 'omniauth-twitter', '~> 1.4'
gem 'omniauth-google-oauth2', '~> 0.8.0'
gem 'omniauth-yahoojp', '~> 0.2.1'
  # omniauth-oauth2のバージョンアップに対応した版（有志作成）
gem 'omniauth-line', git: 'https://github.com/gomo/omniauth-line.git', branch: 'master'
gem 'omniauth-facebook', '~> 6.0'

group :production, :staging do
  gem 'unicorn', '~> 5.5', '>= 5.5.3'
  gem 'capistrano', '~> 3.11', '>= 3.11.2'
  gem 'capistrano-bundler', '~> 1.6'
  gem 'capistrano-rails', '~> 1.4'
  gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.6'
  gem 'capistrano3-unicorn', '~> 0.2.1'
  gem 'ed25519'
  gem 'bcrypt_pbkdf'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 4.0.0.beta4'
  gem 'faker', '~> 2.10'
  gem 'factory_bot', '~> 5.1.1'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end
