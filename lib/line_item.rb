class LineItem
  
  attr_reader :amount

  def initialize(rental)
    @rental = rental
    @amount = rental.total_cost
  end

  def to_s
    "\t#{@rental.movie.title}\t#{@amount}\n"
  end
end
