require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

# Additional requires below this line

# Ensure ActiveRecord is initialized correctly
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  # Ensure ActiveRecord support is enabled
  config.use_transactional_fixtures = true
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # Comment or remove this line to avoid disabling ActiveRecord
  # config.use_active_record = false

  # Automatically mix in different behaviors based on the file location
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  # Configure shoulda-matchers
  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
end
