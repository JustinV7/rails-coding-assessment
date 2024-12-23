module Api
  class WeatherForecastsController < Api::ApplicationController
    rescue_from ThirdParty::Errors::NotFoundError, with: :not_found
    rescue_from ThirdParty::Errors::ClientError, with: :unprocessable
    rescue_from ThirdParty::Errors::ServerError, with: :fatal_error
    rescue_from ThirdParty::Errors::UnexpectedResponseError, with: :fatal_error

    def_param_group :forecast_data do
      property :temp, Float, desc: 'Forecasted temperature at time of Forecast.'
      property :min, Float, desc: 'Forecasted Low Temperature for the day.'
      property :max, Float, desc: 'Forecasted High Temperature for the day.'
      property :datetime, String, desc: 'DateTime string for forecast values.'
    end

    def_param_group :address_error do
      property :message, String, desc: 'Error from helper'
    end

    api :POST, '/api/weather_forecasts/location', 'Weather Forecast by Location'
    param :address, String, desc: 'Location address for weather API call.', required: true
    returns array_of: :forecast_data
    returns :address_error, code: 422
    def location
      address = params[:address]
      @subject = address
      forecast = Rails.cache.fetch("forecast-location-#{address}") do
        ThirdParty::WeatherApiHelper.new(address).forecast
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
