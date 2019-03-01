class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

What would happen if I called the methods like shown below?

tv = Television.new # creates an instance of the Television class
tv.manufacturer # NoMethodError
tv.model # executes the 'method logic' in the Television#model instance method

Television.manufacturer # executes the 'method logic' in the Television#manufacturer class method
Television.model # NoMethodError
