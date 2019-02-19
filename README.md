# How to use

Type `thor info:stock DIS 2019-02-01 2019-02-17` in command line to check the stock values of DIS between 1st February and 17th February 2019.
Dates need to be given in YYYY-MM-DD format.
The command will then post a message in the stocks-challenge.slack.com channel

# Notes

I was in doubt whether to create a `rake task`, but then I opted for `thor`, as it seemed more articulated and powerful.

I tried to separate each responsibility and therefore created 3 service objects:

- a `connection_request` object, responsible for creating the connection to the external Quandl EOD API via Faraday
- a `stock_request` object that creates an instance of `connection_request` with the responsibility of creating a response
- a `calculator` object providing calculation methods for rate of return and drawdowns
- a `stock_info` object that wraps `calculator` , `stock_request` and the webhook to Slack

With a "wrapper object" like `stock_info`, the `thor` script results much more simplified, and the 4 objects can be also reused for other purposes.
A note: the Slack webhook trigger could be in my opinion also refactored in a separate object or module, to be called async via a `Sidekiq` job.
Currently the Slack trigger is not performed async.

# Previous notes

## Notes on commit `first_version`

My first approach was to write a Rails API - almost automatically, without reflecting too much
Then, I had to face the goal is to launch a request to the Quandl EOD Api through the command line.
Putting all the logics (creation of request, calculation of rate of return/max drawdown) in one file, like in this case `lib/stock.rb` is not scalable nor clean.
I would need to create a Service that can return the request and calculations and a separate simple Ruby file that collects the user inputs, calls this service and puts on the command line the required stock info

## Notes on commit `second_version`

My second approach looked for the main object of our simple application: the creation of a stock info. Now we have 2 options:

1. We can create a service object called "StockInfo" that will be initialized each time with the response data and its calculations. Pro: it's light and serves well the simple purpose of receiving notifications with the calculations of desired stock Con: data are not persisted
2. We can create a model object called "StockInfo" and persist data in the database for future use. Pro: we may reuse data and calculations for further applications/analysis Con: it might be heavier on database resources? Depending on the volume of users and/or frequency of use

I decided to separate responsibilities as much as possible and used exclusively service objects
