source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'rake', '~> 10.0'
gem 'dotenv'

# Web Framework
gem 'syro', '~> 3.1'
gem 'puma'
gem 'rack_csrf'
gem 'rack', '>= 2.0'
gem 'dry-transaction'
gem 'dry-container'
gem 'dry-auto_inject'
gem 'shield'
gem 'mote'
gem 'tas'
gem 'hache'
gem 'nobi'
gem 'malone'
gem 'scrivener'

# Persistence
gem 'redic'
gem 'ohm'
gem 'ohm-contrib'

gem 'bcrypt'

group :development do
  gem 'sass'
  gem 'bourbon'
  gem 'neat'
  gem 'bitters'
end

group :test do
  gem 'cucumber', '~> 3.0'
  gem 'rspec', '~> 3.0'
  gem 'rack-test', '~> 1.0'
  gem 'factis', '~> 1.0'
  gem 'simplecov', '~> 0.16.1'
  gem 'database_cleaner'
  gem 'redis'
  gem 'capybara'
  gem 'timecop'
end
