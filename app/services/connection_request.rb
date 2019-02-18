require 'faraday'
require 'faraday_middleware'

class ConnectionRequest
  URL = "https://www.quandl.com/api/v3/datasets/EOD/"

  def self.conn
    Faraday.new(url: URL) do |faraday|
        faraday.response :json
        faraday.response :logger do | logger |
          logger.filter(/(api_key=)(\w+)/,'\1[REMOVED]')
        end
        faraday.adapter  Faraday.default_adapter
      end
    end

  def self.get_response(stock, start_date, end_date)
    self.conn.get("#{stock}.json?end_date=#{end_date}&start_date=#{start_date}&api_key=xQRbCbFbjDt8vZxZh5hc")
  end
end