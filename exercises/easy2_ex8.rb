class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    # can't call a private method using an explicit
    # receiver (unless its a setter method)
    # self.expand(3)
    expand(3)
  end

  private

  def expand(n)
    @string * n
  end
end

expander = Expander.new('xyz')
puts expander
