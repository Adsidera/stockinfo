require 'colorize'

class Info < Thor

  desc :stock, "generate stock infos"
    def stock(*args)
      require './config/environment'

      info = StockInfo.new(*args)

      puts "***************************************************".yellow
      puts "Stock Data for #{info.code} between #{info.start_date} - #{info.end_date}".yellow
      puts "***************************************************".yellow
      puts "\n"

      info.daily_closures_info
      puts "\n"

      puts "First 5 Drawdowns:".cyan
      info.daily_drawdowns_info
      puts "\n"

      puts "Max Drawdown:".cyan
      info.max_drawdown_info
      puts "\n"

      puts "Return:".cyan
      info.return_info

      info.delivery_to_slack
      puts "\n"

      puts 'Sent stock infos on stocks-challenge.slack.com'
    end
end