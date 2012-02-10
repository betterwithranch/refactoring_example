class Rental
  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie, @days_rented = movie, days_rented
    add_cost_calculator
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

  def add_cost_calculator
    #constantize category to include calculator by convention
    name = @movie.category.to_s.split("_").map(&:capitalize).join
    self.extend Object.const_get("#{name}CostCalculator")
  end
end
