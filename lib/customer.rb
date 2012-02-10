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
    Statement.new(self).generate
  end
end
