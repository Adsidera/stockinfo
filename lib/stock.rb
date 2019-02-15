require 'faraday'
require 'faraday_middleware'
require 'highline'
require 'colorize'

cli = HighLine.new
puts "\u{1f30f}"
puts "Welcome to Stock Info".red
puts "  "
stock = cli.ask "What stock should I search?".cyan
start_date = cli.ask "Type the start date".cyan
end_date = cli.ask "Type the end date".cyan
url = "https://www.quandl.com/api/v3/datasets/EOD/"
conn = Faraday.new(url: url) do |faraday|
        faraday.response :json
        faraday.response :logger do | logger |
          logger.filter(/(api_key=)(\w+)/,'\1[REMOVED]')
        end
        faraday.adapter  Faraday.default_adapter
      end
response = conn.get("#{stock}.json?start_date=#{start_date}&end_date=#{end_date}&api_key=xQRbCbFbjDt8vZxZh5hc")
initial_date = response.body["dataset"]["data"].select { |date| date[0] == start_date }.flatten
initial_value = initial_date[4]
final_date = response.body["dataset"]["data"].select { |date| date[0] == end_date }.flatten
final_value = final_date[4]
puts " /////// HERE ARE THE RESULTS FOR #{stock.capitalize} ///////".green
puts  "#{stock} -- Max Return: #{(final_value - initial_value)/initial_value}".red