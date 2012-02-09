class Rental
  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie, @days_rented = movie, days_rented
  end

  def total_cost
    this_amount = 0
    case @movie.price_code
    when Movie::REGULAR
      this_amount += 2
      this_amount += (@days_rented - 2) * 1.5 if @days_rented > 2
    when Movie::NEW_RELEASE
      this_amount += @days_rented * 3
    when Movie::CHILDRENS
      this_amount += 1.5
      this_amount += (@days_rented - 3) * 1.5 if @days_rented > 3
    end
    this_amount
  end

  def renter_points_earned
    points = 1
    # add bonus for a two day new release rental
    points += 1 if @movie.price_code == Movie::NEW_RELEASE && @days_rented > 1
    points
  end
end
