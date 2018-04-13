source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'rake', '~> 10.0'

# Web Framework
gem 'syro', '~> 3.1'
gem 'puma'
gem 'rack_csrf'
gem 'rack', '>= 2.0'
gem 'dry-transaction'
gem 'dry-container'
gem 'dry-auto_inject'

# Persistence
gem 'redic'
gem 'ohm'
gem 'ohm-contrib'

gem 'bcrypt'

group :development, :test do
  gem 'dotenv'
  gem 'sqlite3'
end

group :production do
  gem 'pg'
end

group :test do
  gem 'cucumber', '~> 3.0'
  gem 'rspec', '~> 3.0'
  gem 'rack-test', '~> 1.0'
  gem 'rom-factory', '~> 0.5'
  gem 'factis', '~> 1.0'
  gem 'simplecov', '~> 0.16.1'
  gem 'database_cleaner'
  gem 'redis'
end
