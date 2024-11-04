# require 'simplecov'
# SimpleCov.start 'rails' # coverage files are not generating for unknown reason

ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def response_payload
    JSON.parse(response.body) if response.body.valid_json?
  end
end
