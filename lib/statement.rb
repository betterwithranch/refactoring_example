class Statement
  
  attr_accessor :total_amount
  attr_accessor :total_renter_points

  def initialize(customer)
    @customer = customer
    generate
  end

  def header
    "Rental Record for #{@customer.name}\n"
  end

  def body
    @line_items.join
  end

  def footer
    "Amount owed is #{@total_amount}\n" +
    "You earned #{@total_renter_points} frequent renter points"
  end

  def to_s
    header + body + footer
  end

  protected

  def generate
    @total_amount, @total_renter_points = 0, 0
    @line_items = @customer.rentals.map do |rental| 
      calculate_totals(rental)
      LineItem.new(rental)
    end
  end

  def calculate_totals(rental)
    # determine amounts for each line
    @total_amount += rental.total_cost

    # add frequent renter points
    @total_renter_points += rental.renter_points_earned
  end
end
