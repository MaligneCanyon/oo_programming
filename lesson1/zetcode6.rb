# 3 ways to def an instance method in R.

class Wood
  def info
    "This is a wood object"
  end
end
wood = Wood.new
p wood.info # => "This is a wood object"

class Brick
  attr_accessor :info
end
brick = Brick.new
brick.info = "This is a brick object" # setter method; the str is stored in the @info instance var
p brick.info # => "This is a brick object" # getter method

class Rock
end
rock = Rock.new
def rock.info
  p self.class # => Rock (no quotes, not a String)
  p self.class.name # => "Rock"
  "This is a rock object"
end
p rock.info # => "This is a rock object"
p Rock.name # => "Rock"
