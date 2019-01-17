# 3 ways to def an instance method in R.

class Wood
  def info
    "This is a wood object"
  end
end
wood = Wood.new
p wood.info

class Brick
  attr_accessor :info
end
brick = Brick.new
brick.info = "This is a brick object" # setter method; the str is stored in the @info instance var
p brick.info # getter method

class Rock
end
rock = Rock.new
def rock.info
  puts self.class
  puts self.class.name
  "This is a rock object"
end
p rock.info
p Rock.name
