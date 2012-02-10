class Rental
  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie, @days_rented = movie, days_rented
    self.extend Object.const_get("#{@movie.price_code_key}CostCalculator")
  end

  def renter_points_earned
    points = 1
    # add bonus for a two day new release rental
    points += 1 if @movie.price_code == Movie::NEW_RELEASE && @days_rented > 1
    points
  end

  def total_cost
    base_cost + overdue_cost 
  end
end
