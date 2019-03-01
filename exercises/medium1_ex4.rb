class CircularQueue
  attr_accessor :arr, :newest, :oldest

  def initialize(size)
    @arr = Array.new(size, nil)
    @oldest = nil
    @newest = nil
  end

  def enqueue(value)
    if newest # there's something other than nil in the arr
      self.newest = incr(newest)
      self.oldest = incr(oldest) if newest == oldest  # we are replacing the oldest elem
    else # all arr elems are nil
      self.newest = 0
      self.oldest = 0
    end
    arr[newest] = value
  end

  def dequeue
    return nil if arr.none? # rtn nil if all arr elems are nil
    value = arr[oldest] # save the oldest arr elem
    arr[oldest] = nil # replace the oldest elem w/ nil
    if arr.none? # there was only one non-nil elem left
      self.oldest = nil
      self.newest = nil
    else
      self.oldest = incr(oldest)
    end
    value # rtn the (saved) oldest arr elem
  end

  def incr(ndx)
    ndx += 1
    ndx = 0 if ndx == arr.size # rollover
    ndx
  end
end


queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

# The above code should display true 15 times.
