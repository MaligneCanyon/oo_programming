class Greeting
  def self.greet(message)
    puts message
  end
end

class Hello < Greeting
  def self.hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# case 5:

Hello.hi # => NoMethodError
# can fix by prefixing the Hello#hi and Greeting#greet method names w/ 'self'
