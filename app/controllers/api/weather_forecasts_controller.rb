module Api
  class WeatherForecastsController < Api::ApplicationController
    rescue_from ThirdParty::Errors::NotFoundError, with: :not_found
    rescue_from ThirdParty::Errors::ClientError, with: :unprocessable
    rescue_from ThirdParty::Errors::ServerError, with: :fatal_error
    rescue_from ThirdParty::Errors::UnexpectedResponseError, with: :fatal_error

    api :POST, '/api/weather_forcats/location'
    param :address, String, desc: 'Location address for weather API call.', required: true
    def location
      address = params[:address]
      @subject = address
      forecast = Rails.cache.fetch("forecast-location-#{address}") do
        ThirdParty::WeatherApiHelper.new(location: address).forecast
      end
      render_json(forecast)
    end

    protected

    def not_found
      render_not_found(@subject)
    end

    def unprocessable
      render_unprocessable(@subject)
    end

    def fatal_error
      render_fatal(@subject)
    end

  end
end
