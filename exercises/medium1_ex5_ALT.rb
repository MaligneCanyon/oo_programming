class Minilang
  attr_accessor :reg, :stack
  attr_reader :str

  def initialize(str)
    @str = str
    @stack = []
    @reg = 0
  end

  def eval
    cmds = str.split
    cmds.each do |cmd|
      if cmd.to_i.to_s == cmd # an int
        self.reg = cmd.to_i
      else
        begin
          self.send cmd.downcase.to_sym
        rescue NoMethodError
          puts "Invalid token: #{cmd}"
          break
        end
      end
    end
    puts
  end

  def push
    stack << reg
  end

  def add
    self.reg += stack.pop
  end

  def sub
    self.reg -= stack.pop
  end

  def mult
    self.reg *= stack.pop
  end

  def div
    self.reg /= stack.pop
  end

  def mod
    self.reg %= stack.pop
  end

  def pop
    self.reg = stack.pop
  end

  def print
    puts reg == nil && stack.empty? ? "Empty stack!" : reg
  end
end


Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
