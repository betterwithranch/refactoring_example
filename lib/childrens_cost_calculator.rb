module ChildrensCostCalculator
  def base_cost
    1.5
  end

  def overdue_cost
    ((@days_rented - 3) * 1.5 if @days_rented > 3) || 0
  end
end
