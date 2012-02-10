class LineItem
  
  attr_reader :amount

  def initialize(rental)
    @rental = rental
    @amount = rental.total_cost

  end

  def to_s
    # show figures for this rental
    "\t" + @rental.movie.title + "\t" + @amount.to_s + "\n"
  end
end
