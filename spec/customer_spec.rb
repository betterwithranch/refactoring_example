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
  end
end
