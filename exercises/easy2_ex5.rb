class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

# Something.new calls .initialize (which initializes instance var @data to pt
# to String obj 'Hello')
thing = Something.new

# Something.dupdata calls the .dupdata class method, so this puts 'ByeBye'
puts Something.dupdata

# thing.dupdata calls the .dupdata instance method, which rtns 'HelloHello', so
# this puts 'HelloHello'
puts thing.dupdata
