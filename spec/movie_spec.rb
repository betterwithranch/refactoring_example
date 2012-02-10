require File.join(File.dirname(__FILE__), '../customer.rb')

describe Movie do
  it 'should have constants for the categories' do
    Movie::REGULAR.should == 0
    Movie::NEW_RELEASE.should == 1
    Movie::CHILDRENS.should == 2
  end
end
