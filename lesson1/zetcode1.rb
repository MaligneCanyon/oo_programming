class Some
  def method1
    puts "public method1 called"
  end

  public

  def method2
    puts "public method2 called"
  end

  def method3
    puts "public method3 called"
    # 'self' refers to the calling obj, so the next two lines are equiv
    method1
    self.method1
  end
end

s = Some.new
s.method3
# => public method3 called
#    public method1 called
#    public method1 called
