class Statement
  
  # TODO: test seams - remove after refactor
  attr_accessor :total_statement_amount
  attr_accessor :total_renter_points

  def initialize(customer)
    @customer = customer
  end

  def generate
    @total_statement_amount, @total_renter_points = 0, 0
    header + body + footer
  end

  def header
    "Rental Record for #{@customer.name}\n"
  end

  def body
    result = ''
    @customer.rentals.each do |element|

      # determine amounts for each line
      this_amount = element.total_cost
      @total_statement_amount += this_amount

      # add frequent renter points
      @total_renter_points += element.renter_points_earned

      # show figures for this rental
      result += "\t" + element.movie.title + "\t" + this_amount.to_s + "\n"
    end
    result
  end

  def footer
    result = "Amount owed is #{@total_statement_amount.to_s}\n" +
      "You earned #{@total_renter_points.to_s} frequent renter points"
  end
end
