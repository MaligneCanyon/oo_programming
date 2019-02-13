class FixedArray
  attr_reader :size, :arr

  def initialize(size)
    @size = size
    @arr = Array.new(size, nil)
  end

  def [] (ndx)
    ndx = size + ndx if ndx < 0
    if (0...size).include?(ndx)
      arr[ndx]
    else
      raise IndexError
    end
  end

  def []=(ndx, value)
    ndx = size + ndx if ndx < 0
    if (0...size).include?(ndx)
      arr[ndx] = value
    else
      raise IndexError
    end
  end

  def to_a
    arr.clone
  end

  def to_s
    arr.inspect
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
