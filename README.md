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

## Notes on commit `second_version`

My second approach looked for the main object of our simple application: the creation of a stock info. Now we have 2 options:

1. We can create a service object called "StockInfo" that will be initialized each time with the response data and its calculations. Pro: it's light and serves well the simple purpose of receiving notifications with the calculations of desired stock Con: data are not persisted
2. We can create a model object called "StockInfo" and persist data in the database for future use. Pro: we may reuse data and calculations for further applications/analysis Con: it might be heavier on database resources? Depending on the volume of users and/or frequency of use
   I decided to go for a couple of service objects (one responsible for the connection request, and the other one for the calculations) and for a model object (without ActiveRecord) - I wanted to decouple as much as possible then the connection from the stock info request.

# Linking the service objects in Thor commands

I was in doubt whether to create a `rake task`, but then I opted for `thor`, as it seemed more articulated and powerful.
