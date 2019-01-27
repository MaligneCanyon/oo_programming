class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

trip = RoadTrip.new
p trip.predict_the_future # you are going on a trip

class A
  def method1
    method2
  end
  def method2
    p "hi from #{self.class}"
  end
end

class B < A
  def method2
    p "hi from #{self.class}"
  end
end

B.new.method1 # => hi from B
