class Rental
  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie, @days_rented = movie, days_rented
    self.extend Object.const_get("#{@movie.price_code_key}CostCalculator")
  end

  def renter_points_earned
    1 + renter_points_bonus
  end

  def renter_points_bonus
    renter_bonus_earned? ? 1 : 0
  end

  def renter_bonus_earned?
    @movie.price_code == Movie::NEW_RELEASE && @days_rented > 1 
  end

  def total_cost
    base_cost + overdue_cost 
  end
end
