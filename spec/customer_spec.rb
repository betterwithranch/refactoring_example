require File.join(File.dirname(__FILE__), '../customer.rb')

describe Customer do

  let(:customer) { Customer.new('Craig') }
  let(:childrens_movie) { Movie.new('Shrek', Movie::CHILDRENS) }
  let(:regular_movie) { Movie.new('Star Wars', Movie::REGULAR) }
  let(:new_release_movie) { Movie.new('Chronicle', Movie::NEW_RELEASE) }

  describe '#statement' do
    it 'should use statement generator' do
      statement = mock(Statement).as_null_object
      statement.should_receive(:generate).and_return('statement contents')
      Statement.should_receive(:new).and_return(statement)
      customer.statement.should == 'statement contents'
    end
  end
end
