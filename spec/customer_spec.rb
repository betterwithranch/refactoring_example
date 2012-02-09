require File.join(File.dirname(__FILE__), '../customer.rb')

describe Customer do
  it 'statement should not be empty' do
    c = Customer.new('Craig')
    c.add_rental(Rental.new(Movie.new('Shrek', Movie::CHILDRENS), 2))
    c.statement.should_not be_empty
  end
end
