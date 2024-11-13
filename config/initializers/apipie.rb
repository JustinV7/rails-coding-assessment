Apipie.configure do |config|
  config.app_name                = "AppleApp"
  config.api_base_url            = "http://localhost:3000"
  config.doc_base_url            = "/apipie"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/**/*.rb"
end
