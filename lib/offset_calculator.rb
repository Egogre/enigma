class OffsetCalculator
  attr_reader :day, :month, :year
  
  def initialize(message_date)
    @day = message_date.day
    @month = message_date.month
    @year = message_date.year
  end
  
  def date_ddmmyy
    (day_string + two_digit_month_string + two_digit_year_string).to_i
  end
  
  def offsets
    {:A_offset => a_offset,
     :B_offset => b_offset,
     :C_offset => c_offset,
     :D_offset => d_offset,
     :E_offset => e_offset}
  end
  
  private
  
  def day_string
    day.to_s
  end
  
  def two_digit_month_string
    month.to_s.rjust(2, "0")
  end
  
  def two_digit_year_string
    year.to_s[-2..-1]
  end
  
  def date_squared_string
    (date_ddmmyy**2).to_s
  end
  
  def a_offset
    date_squared_string[-5].to_i
  end
  
  def b_offset
    date_squared_string[-4].to_i
  end
  
  def c_offset
    date_squared_string[-3].to_i
  end
  
  def d_offset
    date_squared_string[-2].to_i
  end
  
  def e_offset
    date_squared_string[-1].to_i
  end
  
end
