# frozen_string_literal: true

source 'https://rubygems.org'

# General
gem 'dotenv' # Development/test environment variables
gem 'faraday' # Make requests to Jira API
gem 'fast-mcp' # Easy MCP servers
gem 'logger' # Logging

group :development do
  gem 'rubocop', require: false # Ruby code style checking and formatting
  gem 'rubocop-factory_bot' # FactoryBot specific rules for RuboCop
  gem 'rubocop-rspec' # RSpec specific rules for RuboCop
end

group :development, :test do
  # Debugging
  gem 'pry' # Interactive REPL and runtime developer console
  gem 'pry-byebug' # Adds step-by-step debugging to Pry
  gem 'pry-doc' # Fetch documentation for source code
  gem 'pry-stack_explorer' # Stack navigation commands for Pry

  gem 'dead_end' # Find the cause of syntax errors
  gem 'guard' # Watch files
  gem 'guard-rspec' # Watch for changes in code and spec files and run specs
  gem 'hashdiff' # Diff hashes
  gem 'omg-attrs' # Inspect any object and its children via object.attrs
end

group :test do
  gem 'factory_bot' # Test data generation
  gem 'faker' # Generate fake data for tests
  gem 'rspec' # Testing framework
  gem 'shoulda-matchers' # Collection of testing matchers
end
