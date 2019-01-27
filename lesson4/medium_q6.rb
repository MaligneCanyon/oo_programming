# class Computer
#   attr_accessor :template

#   def create_template
#     @template = "template 14231" # initializes the @template instance var
#   end

#   def show_template
#     template # rtns the value of the @template instance var
#   end
# end

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231" # calls the setter to initialize the @template instance var
  end

  def show_template
    # calls the setter method, which rtns its input arg (nil in this case); so show_template rtns nil ?
    # no, calls the getter method ('self' is superfulous), which
    # rtns the value of the @template instance var (as in the first Computer class def)
    # => no dif in fn'ality
    self.template
  end
end

comp = Computer.new
comp.create_template
p comp.show_template
