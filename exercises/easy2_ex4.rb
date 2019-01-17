class Transform
  def self.lowercase(string)
    string.downcase
  end

  def initialize(str)
    @str = str
  end

  def uppercase
    @str.upcase
  end
end

my_data = Transform.new('abc')
puts my_data.uppercase # => ABC
puts Transform.lowercase('XYZ') # => xyz
