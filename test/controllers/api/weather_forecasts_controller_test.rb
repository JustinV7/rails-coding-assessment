require "test_helper"

class Api::WeatherForecastsControllerTest < ActionDispatch::IntegrationTest
  def test_request_location
    post location_api_weather_forecasts_path(address: '21377 East Progress Ave., Centennial CO 80015')
    assert_response :ok
    assert_equal %w(temp min max datetime), response_payload.map(&:keys).flatten.uniq
  end

  def test_unknown_address_error
    post location_api_weather_forecasts_path(address: '0000 XYZ St, Denver, CO')
    assert_response :unprocessable_entity
  end
end
