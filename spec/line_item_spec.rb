require File.join(File.dirname(__FILE__), '../customer.rb')

describe LineItem do
  describe '#to_s' do
    it 'should return statement line item for rental' do
      movie = Movie.new('Shrek', Movie::CHILDRENS)
      rental = Rental.new(movie, 2)

      line_item = LineItem.new(rental)
      line_item.to_s.should == "\t#{movie.title}\t#{rental.total_cost}\n"
    end
  end
end
