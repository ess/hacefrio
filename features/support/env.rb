require 'simplecov'

SimpleCov.coverage_dir 'coverage/features'
SimpleCov.start do
  add_filter '/spec'
  add_filter '/features'
end

ENV['RACK_ENV'] = 'test'

require 'rspec'
