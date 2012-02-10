require File.join(File.dirname(__FILE__), '../customer.rb')

describe Statement do
  let(:customer) { Customer.new('Craig') }
  let(:childrens_movie) { Movie.new('Shrek', Movie::CHILDRENS) }
  let(:regular_movie) { Movie.new('Star Wars', Movie::REGULAR) }
  let(:new_release_movie) { Movie.new('Chronicle', Movie::NEW_RELEASE) }

  before :each do
    customer.add_rental(Rental.new(childrens_movie, 2))
  end

  describe '#header' do
    it 'should return the correct text' do
      statement = Statement.new(customer)
      statement.generate
      statement.header.should == "Rental Record for #{customer.name}\n"
    end
  end

  describe '#footer' do
    it 'should return the correct text' do
      statement = Statement.new(customer)
      statement.generate
      lines = statement.footer.split("\n")
      lines[0].should ==  "Amount owed is #{customer.rentals.map(&:total_cost).reduce(&:+)}" 
      lines[1].should == "You earned #{customer.rentals.map(&:renter_points_earned).reduce(&:+)} frequent renter points"
    end
  end

  describe '#body' do
    it 'should include a single rental' do
      statement = Statement.new(customer)
      statement.generate
      lines = statement.body.split("\n")
      lines[0].should == "\t#{customer.rentals[0].movie.title}\t#{customer.rentals[0].total_cost}"
    end

    it 'should include multiple rentals' do
      customer.add_rental(Rental.new(regular_movie, 2))
      statement = Statement.new(customer)
      statement.generate
      lines = statement.body.split("\n")
      lines[0].should == "\t#{customer.rentals[0].movie.title}\t#{customer.rentals[0].total_cost}"
      lines[1].should == "\t#{customer.rentals[1].movie.title}\t#{customer.rentals[1].total_cost}"
    end
  end

  describe '#generate' do

    it 'statement should be header, body, footer' do
      statement = Statement.new(customer)
      result = statement.generate
      result.should == statement.header + statement.body + statement.footer
    end

    it 'should calculate the total points for multiple rentals' do
      customer.add_rental(Rental.new(regular_movie, 2))
      statement = Statement.new(customer)
      statement.generate
      statement.total_amount.should == customer.rentals.map(&:total_cost).reduce(&:+)
    end

    it 'should calculate the total renter points for multiple rentals' do
      customer.add_rental(Rental.new(regular_movie, 2))
      statement = Statement.new(customer)
      statement.generate
      statement.total_renter_points.should == customer.rentals.map(&:renter_points_earned).reduce(&:+)
    end

    it 'should return the same results when run twice' do
      statement = Statement.new(customer)
      first = statement.generate
      second = statement.generate
      first.should == second
    end

    it 'should recalculate if customer is changed' do
      statement = Statement.new(customer)
      first = statement.generate
      customer.add_rental(Rental.new(regular_movie, 2))
      second = statement.generate
      first.should_not == second
    end
  end
end
