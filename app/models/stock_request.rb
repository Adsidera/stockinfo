class StockRequest
  def initialize(stock, start_date, end_date)
    @response = ConnectionRequest.get_response(stock, start_date, end_date)
  end

  def response
    @response
  end

  def data
    response.body["dataset"]["data"].reverse
  end

  def code
    response.body["dataset"]["dataset_code"]
  end

  def start_date
    response.body["dataset"]["start_date"]
  end

  def end_date
    response.body["dataset"]["end_date"]
  end
end