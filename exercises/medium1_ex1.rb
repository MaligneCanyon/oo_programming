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

  def switch_state
    switch
  end

  private

  attr_writer :switch
  attr_reader :switch # added to chk the state

  def flip_switch(desired_state)
    # "unlike all other private method calls, you must specify the receiver
    # when calling a setter method"
    self.switch = desired_state
  end
end

terminator = Machine.new
terminator.start
p terminator.switch_state
# terminator.switch = :off # this works if attr_writer :switch is public
# p terminator.switch_state
terminator.stop
p terminator.switch_state
terminator.flip_switch(:on)
