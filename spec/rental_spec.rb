require File.join(File.dirname(__FILE__), '../customer.rb')

describe Rental do
  let(:childrens_movie) { Movie.new('Shrek', Movie::CHILDRENS) }
  let(:regular_movie) { Movie.new('Star Wars', Movie::REGULAR) }
  let(:new_release_movie) { Movie.new('Chronicle', Movie::NEW_RELEASE) }

  context 'regular movie' do
    it 'should have a total amount of 2 for 1 day' do
      rental = Rental.new(regular_movie, 1)
      rental.total_cost.should == 2
    end

    it 'should have a total amount of 2 for 2 days' do
      rental = Rental.new(regular_movie, 2)
      rental.total_cost.should == 2
    end

    it 'should charge 1.5 extra for one day overdue' do
      rental = Rental.new(regular_movie, 3)
      rental.total_cost.should == 3.5 
    end

    it 'should charge 3 extra for two days overdue' do
      rental = Rental.new(regular_movie, 4)
      rental.total_cost.should == 5
    end
  end

  context 'new release movie' do
    it 'should have a total amount of 3 for 1 day' do
      rental = Rental.new(new_release_movie, 1)
      rental.total_cost.should == 3
    end
    
    it 'should have a total amount of 6 for 2 days' do
      rental = Rental.new(new_release_movie, 2)
      rental.total_cost.should == 6
    end

    it 'should have a total amount of 9 for 3 days' do
      rental = Rental.new(new_release_movie, 3)
      rental.total_cost.should == 9
    end
    
  end

  context 'childrens movie' do
    it 'should have a total amount of 1.5 for <= 3 days' do
      rental = Rental.new(childrens_movie, 2)
      rental.total_cost.should == 1.5
    end

    it 'should have a total amount of 1.5 for 3 days' do
      rental = Rental.new(childrens_movie, 3)
      rental.total_cost.should == 1.5
    end

    it 'should have a total amount of 3 for 4 days' do
      rental = Rental.new(childrens_movie, 4)
      rental.total_cost.should == 3
    end

    it 'should have a total amount of 4.5 for 5 days' do
      rental = Rental.new(childrens_movie, 5)
      rental.total_cost.should == 4.5
    end
  end
end
