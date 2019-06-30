source "https://rubygems.org"
git_source(:github) {|repo| "https://github.com/#{repo}.git" }

ruby "2.6.2"

gem "active_model_serializers", "~> 0.10.0"
gem "bootsnap", ">= 1.1.0", require: false
gem "devise_token_auth"
gem "mysql2", ">= 0.4.4", "< 0.6.0"
gem "puma", "~> 3.11"
gem "rails", "~> 5.2.3"
gem "turbolinks", "~> 5"
gem "webpacker"

group :development, :test do
  gem "pry-byebug"
  gem "pry-doc"
  gem "pry-rails"
  gem "rubocop-rails"
  gem "rubocop-rspec"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "web-console", ">= 3.3.0"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "annotate"
  gem "rails-erd"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails"
  gem "rspec_junit_formatter"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
