module ThirdParty
  class WeatherApiHelper
    attr_reader :location, :url, :content_type

    def initialize(location, content_type=nil)
      @location = location
      @content_type = content_type || 'json'
    end

    def forecast(days = 10)
      begin
        request_hash = {
          key: WEATHER_API_KEY,
          locations: CGI::escape(self.location),
          chronoUnit: 'days',
          forecastDays: days,
          aggregateHours: 24,
          contentType: self.content_type
        }
        @url = "#{forecast_url}?#{request_hash.to_query}"
        party = HTTParty.get self.url

        if [200].include? party.code
          # OK
          weather_data = parse_response(party)
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

    def parse_response(response)
      # Response data to store: 'temp' 'mint' 'maxt' 'datetime'
      weather_data = []
      case self.content_type
      when 'json'
        raise Errors::UnexpectedResponseError.new 'Expected valid JSON' unless response.body.valid_json?
        body = JSON.parse(response.body)
        begin
          body['locations'][CGI.escape(self.location)]['values'].each do |data|
            weather_data << {
              temp: data['temp'], min: data['mint'], max: data['maxt'],
              datetime: DateTime.parse(data['datetimeStr'])
            }
          end
        rescue StandardError => e
          raise ThirdParty::Errors::UnexpectedResponseError.new e.message
        end
      when 'csv'
        raise Errors::UnexpectedResponseError.new 'Expected valid CSV' unless response.body.valid_csv?
        csv = CSV.parse(response.body, headers: true)
        csv.map do |day|
          weather_data << {
            temp: day['Temperature'],
            min: day['Minimum Temperature'],
            max: day['Maximum Temperature'],
            datetime: day['Date time'],
          }
        end
      else nil
      end

      weather_data
    end

    def forecast_url
      'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/weatherdata/forecast'
    end

  end
end
