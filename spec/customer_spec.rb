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
        lines[-2].should =~  /Amount owed is 1.5/ 
        lines[-1].should =~ /You earned \d+ frequent renter points/
      end

      it 'should include the rentals' do
        lines = customer.statement.split("\n")
        lines[1].should =~ /\s*Shrek\s*\d+.*/
      end
    end

    context 'frequent renter points' do
      it 'should be 1 for 1 regular rental night' do
        customer.add_rental(Rental.new(regular_movie, 1))
        customer.statement
        customer.total_renter_points.should == 1
      end

      it 'should be 1 for 2 regular rental nights' do
        customer.add_rental(Rental.new(regular_movie, 2))
        customer.statement
        customer.total_renter_points.should == 1
      end

      it 'should be 1 for 1 childrens rental night' do
        customer.add_rental(Rental.new(childrens_movie, 1))
        customer.statement
        customer.total_renter_points.should == 1
      end

      it 'should be 1 for 2 childrens rental nights' do
        customer.add_rental(Rental.new(childrens_movie, 2))
        customer.statement
        customer.total_renter_points.should == 1
      end

      it 'should be 1 for 1 new release rental night' do
        customer.add_rental(Rental.new(new_release_movie, 1))
        customer.statement
        customer.total_renter_points.should == 1
      end

      it 'should be 2 for 2 new release rental nights' do
        customer.add_rental(Rental.new(new_release_movie, 2))
        customer.statement
        customer.total_renter_points.should == 2
      end

      it 'should be 2 for 3 new release rental nights' do
        customer.add_rental(Rental.new(new_release_movie, 3))
        customer.statement
        customer.total_renter_points.should == 2
      end
    end

  end
end
