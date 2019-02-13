class Machine
  # attr_writer :switch # move to private section

  def start
    # self.flip_switch(:on)
    flip_switch(:on) # can't call a private method using an explicit receiver
  end

  def stop
    # self.flip_switch(:off)
    flip_switch(:off) # ditto
  end

  private

  attr_writer :switch

  def flip_switch(desired_state)
    # "unlike all other private method calls, you must specify the receiver
    # when calling a setter method"
    self.switch = desired_state
  end
end

terminator = Machine.new
terminator.start
p terminator
terminator.stop
p terminator
# terminator.switch = :on # NoMethodError
terminator.flip_switch(:on) # NoMethodError
