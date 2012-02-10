class Movie

  CATEGORIES = { :regular => 0, :new_release => 1, :childrens => 2}

  CATEGORIES.each do |k,v|
    self.const_set(k.upcase, v)
  end
  
  attr_reader :title
  attr_accessor :price_code

  def initialize(title, price_code)
    @title, @price_code = title, price_code
  end

  def price_code_key
    CATEGORIES.invert[price_code].to_s.split("_").map(&:capitalize).join
  end
end
