class InvalidTokenError < RuntimeError; end
class EmptyStackError < RuntimeError; end

class Minilang
  @@stack = [] # only 1 stack exists
  @@reg = 0 # only 1 reg exists

  def initialize(str)
    @str = str # cmd str
  end

  def eval
    error = ''
    cmds = @str.split
    cmds.each do |cmd|
      # puts "cmd == #{cmd}"
      if cmd == cmd.to_i.to_s # int
        @@reg = cmd.to_i
      else # str
        case cmd
        when 'PUSH'  then @@stack << @@reg
        when 'ADD'   then @@reg += pop
        when 'SUB'   then @@reg -= pop
        when 'MULT'  then @@reg *= pop
        when 'DIV'   then @@reg /= pop
        when 'MOD'   then @@reg %= pop
        when 'POP'   then @@reg = pop
        when 'PRINT' then puts @@reg
        else
          begin
            raise InvalidTokenError, "Invalid token: #{cmd}"
          rescue InvalidTokenError => error
            puts error.message
          end
        # else raise InvalidTokenError, "Invalid token: #{cmd}" # raises an InvalidTokenError
        # else raise "Invalid token: #{cmd}" # raises a RuntimeError
        # else puts "Invalid token: #{cmd}" # simply prints an err msg
        end
      end
    end
  end

  def pop
    if @@stack.empty?
      begin
        raise EmptyStackError, 'Empty stack!'
      rescue EmptyStackError => error
        puts error.message
      end
      # raise EmptyStackError, 'Empty stack!'
      # raise 'Empty stack!'
      # puts 'Empty stack!'
    else
      @@stack.pop
    end
  end
end

Minilang.new('PRINT').eval
# 0
Minilang.new('5 PUSH 3 MULT PRINT').eval
# # 15
Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# # 5
# # 3
# # 8
Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# # 10
# # 5
Minilang.new('5 PUSH POP POP PRINT').eval
# # Empty stack!
Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# # 6
Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# # 12
Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# # Invalid token: XSUB
Minilang.new('-3 PUSH 5 SUB PRINT').eval
# # 8
Minilang.new('6 PUSH').eval
# # (nothing printed; no PRINT commands)
