class Q
  attr_reader :name

  def initialize
    @name = 'q'
  end
end

class R < Q; end

rrr = R.new
puts rrr.name # => 'q'
