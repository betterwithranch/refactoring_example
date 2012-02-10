module RegularCostCalculator
  def base_cost
    2
  end

  def overdue_cost
    overdue? ? (@days_rented - 2) * 1.5 : 0
  end

  def overdue?
    @days_rented > 2
  end
end
