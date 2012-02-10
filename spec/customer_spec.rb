require File.join(File.dirname(__FILE__), '../customer.rb')

describe Customer do

  let(:customer) { Customer.new('Craig') }
  let(:childrens_movie) { Movie.new('Shrek', Movie::CHILDRENS) }
  let(:regular_movie) { Movie.new('Star Wars', Movie::REGULAR) }
  let(:new_release_movie) { Movie.new('Chronicle', Movie::NEW_RELEASE) }

  describe '#statement' do
    it 'should use statement generator' do
      statement = mock(Statement).as_null_object
      statement.should_receive(:to_s).and_return('statement contents')
      Statement.should_receive(:new).and_return(statement)
      customer.statement.should == 'statement contents'
    end

    it 'should return the same results when run twice' do
      first = customer.statement
      second = customer.statement
      first.should == second
    end

    it 'should recalculate if customer is changed' do
      first = customer.statement
      customer.add_rental(Rental.new(regular_movie, 2))
      second = customer.statement
      first.should_not == second
    end
  end
end
