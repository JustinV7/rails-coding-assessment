module ThirdParty
  class WeatherApiHelper
    attr_reader :location, :url

    def initialize(location: String)
      @location = location
    end

    def forecast(days = 10)
      begin
        request_hash = {
          key: WEATHER_API_KEY,
          locations: CGI::escape(self.location),
          chronoUnit: 'days',
          forecastDays: days,
          aggregateHours: 24,
          contentType: 'json'
        }
        @url = "#{forecast_url}?#{request_hash.to_query}"
        party = HTTParty.get self.url

        if [200].include? party.code
          # OK
          response = JSON.parse(party.body)
          weather_data = []
          begin
            response['locations'][CGI.escape(self.location)]['values'].each do |data|
              # Response data to store: 'temp' 'mint' 'maxt' 'datetime'
              weather_data << {
                temp: data['temp'], min: data['mint'], max: data['maxt'],
                datetime: DateTime.parse(data['datetimeStr'])
              }
            end
          rescue StandardError => e
            raise ThirdParty::Errors::UnexpectedResponseError.new e.message
          end
        elsif [400, 401, 428].include? party.code
          # Client Errors
          raise ThirdParty::Errors::ClientError.new party.body
        elsif [404].include? party.code
          # Not Found Error
          raise ThirdParty::Errors::NotFoundError.new party.body
        elsif [500].include? party.code
          # Server Errors
          raise ThirdParty::Errors::ServerError.new party.body
        else
          raise ThirdParty::Errors::UnexpectedResponseError.new "Unhandled Internal Error: #{party.body}"
        end

        weather_data
      rescue StandardError => e
        raise e
      end
    end

    private

    def forecast_url
      'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/weatherdata/forecast'
    end

  end
end
