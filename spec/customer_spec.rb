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

    context 'regular movie' do
      it 'should have a total amount of 2 for 1 day' do
        customer.add_rental(Rental.new(regular_movie, 1))
        customer.statement
        customer.total_statement_amount.should == 2
      end

      it 'should have a total amount of 2 for 2 days' do
        customer.add_rental(Rental.new(regular_movie, 2))
        customer.statement
        customer.total_statement_amount.should == 2
      end

      it 'should charge 1.5 extra for one day overdue' do
        customer.add_rental(Rental.new(regular_movie, 3))
        customer.statement
        customer.total_statement_amount.should == 3.5 
      end

      it 'should charge 3 extra for two days overdue' do
        customer.add_rental(Rental.new(regular_movie, 4))
        customer.statement
        customer.total_statement_amount.should == 5
      end
    end

    context 'new release movie' do
      it 'should have a total amount of 3 for 1 day' do
        customer.add_rental(Rental.new(new_release_movie, 1))
        customer.statement
        customer.total_statement_amount.should == 3
      end
      
      it 'should have a total amount of 6 for 2 days' do
        customer.add_rental(Rental.new(new_release_movie, 2))
        customer.statement
        customer.total_statement_amount.should == 6
      end

      it 'should have a total amount of 9 for 3 days' do
        customer.add_rental(Rental.new(new_release_movie, 3))
        customer.statement
        customer.total_statement_amount.should == 9
      end
      
    end

    context 'childrens movie' do
      it 'should have a total amount of 1.5 for <= 3 days' do
        customer.add_rental(Rental.new(childrens_movie, 2))
        customer.statement
        customer.total_statement_amount.should == 1.5
      end

      it 'should have a total amount of 1.5 for 3 days' do
        customer.add_rental(Rental.new(childrens_movie, 3))
        customer.statement
        customer.total_statement_amount.should == 1.5
      end

      it 'should have a total amount of 3 for 4 days' do
        customer.add_rental(Rental.new(childrens_movie, 4))
        customer.statement
        customer.total_statement_amount.should == 3
      end

      it 'should have a total amount of 4.5 for 5 days' do
        customer.add_rental(Rental.new(childrens_movie, 5))
        customer.statement
        customer.total_statement_amount.should == 4.5
      end
    end
  end
end
