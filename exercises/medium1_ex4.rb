class CircularQueue
  attr_accessor :arr, :newest, :oldest

  def initialize(size)
    @arr = Array.new(size)
    @oldest = nil
    @newest = nil
  end

  def enqueue(obj)
    if newest # there's something other than nil in the arr
      self.newest += 1
      self.newest = 0 if newest == arr.size # rollover
      if newest == oldest # we are replacing the oldest elem
        self.oldest += 1
        self.oldest = 0 if oldest == arr.size # rollover
      end
    else # all arr elems are nil
      self.newest = 0
      self.oldest = 0
    end
    arr[newest] = obj
  end

  def dequeue
    return nil unless oldest # rtn nil if all arr elems are nil
    obj = arr[oldest] # save the oldest arr elem
    arr[oldest] = nil # replace the oldest elem w/ nil
    if oldest == newest # there was only one non-nil elem left
      self.oldest = nil
      self.newest = nil
    else
      self.oldest += 1
      self.oldest = 0 if oldest == arr.size # rollover
    end
    obj # rtn the (saved) oldest arr elem
  end
end

queue = CircularQueue.new(3)
# p queue
puts queue.dequeue == nil
# p queue

queue.enqueue(1)
# p queue
queue.enqueue(2)
# p queue
puts queue.dequeue == 1
# p queue

queue.enqueue(3)
# p queue
queue.enqueue(4)
# p queue
puts queue.dequeue == 2
# p queue

queue.enqueue(5)
# p queue
queue.enqueue(6)
# p queue
queue.enqueue(7)
# p queue
puts queue.dequeue == 5
# p queue
puts queue.dequeue == 6
# p queue
puts queue.dequeue == 7
# p queue
puts queue.dequeue == nil
# p queue

# The above code should display true 15 times. <= 7 times
