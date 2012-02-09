require File.join(File.dirname(__FILE__), '../customer.rb')

describe Customer do

  let(:customer) { Customer.new('Craig') }
  let(:childrens_movie) { Movie.new('Shrek', Movie::CHILDRENS) }
  let(:regular_movie) { Movie.new('Star Wars', Movie::REGULAR) }
  let(:new_release_movie) { Movie.new('Chronicle', Movie::NEW_RELEASE) }

  describe '#statement' do
    context 'Statement output' do
      before :each do
        customer.add_rental(Rental.new(childrens_movie, 2))
      end

      it 'statement should start with header' do
        customer.statement.should =~ /Rental Record for Craig\n.*/
      end

      it 'statement should end with footer' do
        lines = customer.statement.split("\n")
        lines[-2].should ==  "Amount owed is #{customer.rentals.map(&:total_cost).reduce(&:+)}" 
        lines[-1].should == "You earned #{customer.rentals.map(&:renter_points_earned).reduce(&:+)} frequent renter points"
      end

      it 'should include a single rental' do
        lines = customer.statement.split("\n")
        lines[1].should == "\tShrek\t#{customer.rentals[0].total_cost}"
      end

      it 'should include multiple rentals' do
        customer.add_rental(Rental.new(regular_movie, 2))
        lines = customer.statement.split("\n")
        lines[1].should == "\t#{customer.rentals[0].movie.title}\t#{customer.rentals[0].total_cost}"
        lines[2].should == "\t#{customer.rentals[1].movie.title}\t#{customer.rentals[1].total_cost}"
      end

      it 'should calculate the total points for multiple rentals' do
        customer.add_rental(Rental.new(regular_movie, 2))
        customer.statement
        customer.total_statement_amount.should == customer.rentals.map(&:total_cost).reduce(&:+)
      end

      it 'should calculate the total renter points for multiple rentals' do
        customer.add_rental(Rental.new(regular_movie, 2))
        customer.statement
        customer.total_renter_points.should == customer.rentals.map(&:renter_points_earned).reduce(&:+)
      end
    end
  end
end
