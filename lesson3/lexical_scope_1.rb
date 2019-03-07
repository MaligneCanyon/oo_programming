# lexical scoping of constants

class Alpha
  BIG = 1000

  def get_big
    BIG
  end
end

class Beta < Alpha
  BIG = 10000
end

puts Alpha::BIG
puts Beta::BIG
puts Beta.new.get_big # => 1000
