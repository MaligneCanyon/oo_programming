# 3 ways to def a class method in R.

class Wood
  def self.info
    "This is a Wood class"
  end
end
p Wood.info

class Brick
  class << self
    def info
      "This is a Brick class"
    end
  end
end
p Brick.info

class Rock
end
def Rock.info
  "This is a Rock class"
end
p Rock.info
