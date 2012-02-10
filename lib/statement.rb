class Statement
  
  attr_accessor :total_amount
  attr_accessor :total_renter_points

  def initialize(customer)
    @customer = customer
  end

  def generate
    @header, @body, @footer = nil, nil, nil
    @total_amount, @total_renter_points = 0, 0
    header + body + footer
  end

  def header
    @header ||= "Rental Record for #{@customer.name}\n"
  end

  def body
    return @body if @body
    @body = ''
    @customer.rentals.each do |element|

      # determine amounts for each line
      this_amount = element.total_cost
      @total_amount += this_amount

      # add frequent renter points
      @total_renter_points += element.renter_points_earned

      # show figures for this rental
      @body += "\t" + element.movie.title + "\t" + this_amount.to_s + "\n"
    end
    @body
  end

  def footer
    @footer ||= "Amount owed is #{@total_amount.to_s}\n" +
      "You earned #{@total_renter_points.to_s} frequent renter points"
  end

end
