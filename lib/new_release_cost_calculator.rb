module NewReleaseCostCalculator
  def base_cost
    @days_rented * 3
  end

  def overdue_cost
    0
  end

  def overdue?
    false
  end
end
