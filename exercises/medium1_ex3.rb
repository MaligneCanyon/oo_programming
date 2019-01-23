class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student # 1
  def initialize(name, year, parking)
    @parking = parking # 2
    super(name, year) # 3
  end
end

class Undergraduate < Student # 4
  def initialize(name, year)
    super # 5
  end
end
