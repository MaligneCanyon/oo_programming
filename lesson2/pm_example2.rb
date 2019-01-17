#PM w/ duck typing

class Wedding # class_of_interest
  attr_reader :guests, :flowers, :songs

   # w/i the class_of_interest  def a general method, pass it an arr of
   # classes for which you want to model implementation-specific behavior
  def prepare(preparers)
    preparers.each do |preparer|
      # call a general (wrapper) method and pass it the class_of_interest
      preparer.prepare_wedding(self)
    end
  end
end

class Chef
  # def the wrapper method for each of the classes w/ implementation-specific
  # behavior, and call the method modeling that behavior, passing it the
  # relevant portion of the class_of_interest
  def prepare_wedding(wedding)
    prepare_food(wedding.guests)
  end

  def prepare_food(guests)
    # implementation
  end
end

# to add another preparer, just need to def a class and add the implementation-
# specific code (called w/i the prepare_wedding wrapper method)

class Decorator
  def prepare_wedding(wedding)
    decorate_place(wedding.flowers)
  end

  def decorate_place(flowers)
    # implementation
  end
end

class Musician
  def prepare_wedding(wedding)
    prepare_performance(wedding.songs)
  end

  def prepare_performance(songs)
    # implementation
  end
end
