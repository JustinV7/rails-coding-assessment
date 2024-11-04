require 'test_helper'

class ThirdParty::WeatherApiHelperTest < ActionDispatch::IntegrationTest
  def test_forecast_success
    #TODO: VCR was removed because of yaml parsing error.
    result = nil
    days = 10
    # VCR.use_cassette('weather_forecast_success') do
      result = ThirdParty::WeatherApiHelper.new(location: '200 E Colfax Ave, Denver, CO 80203').forecast(days)
    # end
    # Results seem to vary by 1 during night hours
    assert result.size == days || result.size == days + 1
  end

  def test_invalid_address_client_error
    #TODO: implement VCR when possible.
    assert_raises(ThirdParty::Errors::ClientError) do
      ThirdParty::WeatherApiHelper.new(location: 'Unknown location, Loompa Land').forecast
    end
  end

  def test_invalid_api_key_client_error
    #TODO: implement VCR when possible.
    ENV['WEATHER_API_KEY'] = SecureRandom.urlsafe_base64(32)
    assert_raises(ThirdParty::Errors::ClientError) do
      ThirdParty::WeatherApiHelper.new(location: '').forecast
    end
  end
end
