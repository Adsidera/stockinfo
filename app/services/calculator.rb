require 'numeric'

class Calculator
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def rate_of_return
    (final_value - initial_value)/initial_value
  end

  def return_percentage
    (rate_of_return*100).round(2)
  end

  def initial_value
    close_values.first
  end

  def final_value
    close_values.last
  end

  def daily_drawdowns
    data.map {|arr| [arr[0].to_date.strftime("%d.%m.%Y"), ((arr[2] - arr[4] )/(arr[2]/100)).round(2)] }
  end

  def drawdowns
    daily_drawdowns.map { |drawdown| drawdown[1] }
  end

  def maximum_drawdown
    drawdowns.max.round(2)
  end

  def max_drawdown_array
    daily_drawdowns.select {|drawdown| drawdown[1] == maximum_drawdown }
  end

  def max_drawdown_day
    max_drawdown_array[0][0].to_date.strftime(" on %d.%m.%Y")
  end

  def max_drawdown
    ((peak_value_before_largest_drop - lowest_value_before_new_high_established) / (peak_value_before_largest_drop))
  end

  def peak_value_before_largest_drop
    values_before_lowest_array.max
  end

  def lowest_value_before_new_high_established
    values_before_new_peak_array.min
  end

  def close_values
    @data.map { |arr| arr[4] }
  end

  def lowest_value_index
    close_values.find_index(close_values.min)
  end

  def values_before_lowest_array
    close_values[0...lowest_value_index]
  end

  def values_remaining
    close_values - values_before_lowest_array
  end

  def peak_values_remaining_index
    values_remaining.find_index(values_remaining.max)
  end

  def values_before_new_peak_array
    values_remaining[0...peak_values_remaining_index]
  end
end