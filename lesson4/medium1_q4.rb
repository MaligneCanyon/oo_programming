class Greeting
  def greet(str)
    puts str
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

Hello.new.hi
Goodbye.new.bye

# alt:
# class Hello < Greeting
#   def hi
#     'hello'
#   end
# end

# class Goodbye < Greeting
#   def bye
#     'goodbye'
#   end
# end

# h = Hello.new
# h.greet(h.hi)

# g = Goodbye.new
# g.greet(g.bye)
