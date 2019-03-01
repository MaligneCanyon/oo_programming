class Cat
  @@cats_count = 0 # counts the number of instances of the Cat class

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# call the cats_count method on the Cat class to rtn the value of the @@cat_count class var
p Cat.cats_count # 0
Cat.new(:tabby)
Cat.new(:house)
p Cat.cats_count # 2
