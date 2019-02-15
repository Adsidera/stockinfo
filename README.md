# Model

Stock

- attributes: `symbol`, `start_date`, `end_date`, `initial_value`, `final_value`

# Quandl EOD Api

endpoint https://www.quandl.com/api/v3/datasets/EOD/{`stocksymbol`}.json?api_key=xQRbCbFbjDt8vZxZh5hc

# Rate of return

is it meant the simple rate of return?
R = FinalValue - InitialValue/InitialValue

# Max Drawdown

Max Drawdown = (Peak value before largest drop - Lowest value before new high established) / (Peak value before largest drop)

# Comments

## Notes on commit `first_version`

My first approach was to write a Rails API - almost automatically, without reflecting too much
Then, I had to face the goal is to launch a request to the Quandl EOD Api through the command line.
Putting all the logics (creation of request, calculation of rate of return/max drawdown) in one file, like in this case `lib/stock.rb` is not scalable nor clean.
I would need to create a Service that can return the request and calculations and a separate simple Ruby file that collects the user inputs, calls this service and puts on the command line the required stock info
