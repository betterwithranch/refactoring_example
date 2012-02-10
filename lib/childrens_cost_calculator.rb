module ChildrensCostCalculator
  def base_cost
    1.5
  end

  def overdue_cost
    overdue? ? (@days_rented - 3) * 1.5 : 0
  end

  def overdue?
    @days_rented > 3
  end
end
