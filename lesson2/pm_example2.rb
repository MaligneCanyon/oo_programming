# PM w/ duck typing

class Wedding # main_class
  attr_reader :guests, :flowers, :songs

   # w/i the main_class def a general (wrapper) method and pass it an instance
   # of each of the classes for which you want to have implementation-specific
   # behavior
  def prepare(preparers)
    preparers.each do |preparer|
      # call a general (wrapper) method and pass it an obj
      preparer.prepare_wedding(self)
    end
  end
end

class Chef
  # def the wrapper method for each of the classes, and have it call an
  # implementation-specific method (that models behavior specific to the class)
  def prepare_wedding(wedding)
    prepare_food(wedding.guests)
  end

  def prepare_food(guests)
    # implementation
  end
end

# to add another preparer, just need to def a class and add the implementation-
# specific code (called w/i the wrapper method)

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
