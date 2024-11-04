# Load the Rails application.
require_relative "application"

# Initialize Constants
Dir["#{Rails.root}/lib/third_party/errors/*.rb"].each {|file| require file }
raise Errors::ClientError.new("API Key missing:\nWEATHER_API_KEY: '#{ENV['WEATHER_API_KEY']}'.") unless ENV['WEATHER_API_KEY'].present?
WEATHER_API_KEY = ENV['WEATHER_API_KEY']

# Initialize the Rails application.
Rails.application.initialize!
