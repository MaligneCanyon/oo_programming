module MyModule; end

class Some
  include MyModule

  def initialize
    method1
    self.method1
  end

  protected

  def method1
    puts "protected method1 called"
  end

end

p Some.ancestors # rtns an arr of class and module names

s = Some.new # 2x => protected method1 called
s.method1 # => NoMethodError
# protected methods can be called w/ or w/o the 'self' keyword, but not from
# outside the class def'n
