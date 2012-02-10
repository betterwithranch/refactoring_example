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
    @body ||= @customer.rentals.map {|rental| line_item(rental)}.join
  end

  def footer
    @footer ||= "Amount owed is #{@total_amount.to_s}\n" +
      "You earned #{@total_renter_points.to_s} frequent renter points"
  end

  def line_item(rental)

    # determine amounts for each line
    @total_amount += rental.total_cost

    # add frequent renter points
    @total_renter_points += rental.renter_points_earned

    LineItem.new(rental)
  end

end
