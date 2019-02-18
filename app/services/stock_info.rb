require 'slack-notifier'
  class StockInfo
    attr_accessor :slack, :calc, :stock, :code
    def  initialize(*args)
      @stock = StockRequest.new(*args)
      @calc = Calculator.new(@stock.data)
      @slack = Slack::Notifier.new(webhook_url)
    end

    def webhook_url
      "https://hooks.slack.com/services/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"
    end

    def code
      @stock.code.upcase
    end

    def start_date
      @stock.start_date.to_date.strftime("%d.%m.%Y")
    end

    def end_date
      @stock.end_date.to_date.strftime("%d.%m.%Y")
    end

    def daily_closures_info
      calc.data.each do |array|
        puts "#{array.first.to_date.strftime("%d.%m.%Y")} Closed at #{array[4]} (#{array[2]} ~ #{array[4]})".yellow
      end
    end

    def daily_drawdowns_info
      calc.daily_drawdowns.first(5).each do |drawdown|
        puts "-#{drawdown[1]}%".red + " on #{drawdown[0]}"
      end
    end

    def max_drawdown_info
      puts maximum_drawdown.red + maximum_drawdown_day
    end

    def return_info
      puts "#{calc.return_percentage}%".green + values_between_dates
    end

    def values_between_dates
      "  #{calc.initial_value} on #{start_date} ~ #{calc.final_value} on #{end_date}"
    end

    def maximum_drawdown
      "-#{calc.maximum_drawdown}%"
    end

    def maximum_drawdown_day
      " #{calc.max_drawdown_day}"
    end

    def delivery_to_slack
      slack.post text: "New Stock Values for #{code.upcase} between #{start_date} - #{end_date}"
      slack.post text: "Daily Drawdowns:"
      calc.daily_drawdowns.first(5).each do |drawdown|
        slack.post text: "-#{drawdown[1]}%" + " on #{drawdown[0]}"
      end
      slack.post text: "Maximum Drawdown: #{maximum_drawdown} on #{maximum_drawdown_day}"
      slack.post text: "Return: #{calc.return_percentage}% (#{values_between_dates})"
    end
  end
