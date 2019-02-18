require 'highline'
require 'colorize'

#This part is responsible for the command line task
  cli = HighLine.new
  puts "\u{1f30f}"
  puts "Welcome to Stock Info".red
  puts "  "
  stock = cli.ask "What stock should I search?".cyan
  start_date = cli.ask "Type the start date".cyan
  end_date = cli.ask "Type the end date".cyan

  # This part is responsible for the connection & response
  response = StockInfo.new(stock, start_date, end_date)

  # This part is responsible for the calculation
  initial_date = response.body["dataset"]["data"].select { |date| date[0] == start_date }.flatten
  initial_value = initial_date[4]
  final_date = response.body["dataset"]["data"].select { |date| date[0] == end_date }.flatten
  final_value = final_date[4]
  puts " /////// HERE ARE THE RESULTS FOR #{stock.capitalize} ///////".green
  puts  "#{stock} -- Max Return: #{(final_value - initial_value)/initial_value}".red
