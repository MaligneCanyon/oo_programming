class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    # can't call a private method using any explicit receiver, incl'ing 'self'
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
