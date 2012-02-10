module RegularCostCalculator
  def base_cost
    2
  end

  def overdue_cost
    ((@days_rented - 2) * 1.5 if @days_rented > 2) || 0
  end
end
