class FixedArray
  attr_accessor :arr

  def initialize(size)
    @arr = Array.new(size)
  end

  def [](ndx)
    if ndx > (arr.size - 1) || ndx < -arr.size # ndx >= 6 or ndx < -5
      raise IndexError
    else
      arr[ndx]
    end
  end

  def to_s
    arr.to_s
  end

  def to_a
    # should use arr.clone instead (see solution)
    arr.to_a
  end

  def []=(ndx, value)
    if ndx > (arr.size - 1) || ndx < -arr.size # ndx >= 6 or ndx < -5
      raise IndexError
    else
      arr[ndx] = value
    end
  end
end

fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]' # to_s must rtn a str

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[7] = 3
  puts false
rescue IndexError
  puts true
end

# The above code should output true 16 times.
