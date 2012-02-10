class Customer
  attr_reader :name
  
  # TODO: test seams - remove after refactor
  attr_accessor :total_statement_amount
  attr_accessor :total_renter_points

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(arg)
    @rentals << arg
  end

  def rentals
    @rentals.clone
  end

  def statement
    s = Statement.new(self)
    report = s.generate
    @total_statement_amount = s.total_statement_amount
    @total_renter_points = s.total_renter_points
    report
  end
end
