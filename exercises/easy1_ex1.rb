# initialize algo:
# - shorten the input msg if it is too long
# - if the width is 0 (default width)
#   - set @message to the input msg
# - elsif the width is less than the message size
#   - ignore it and
#     - set @message to the input msg
# - else
#   - if the width is too wide
#     - make the width narrower
#   - center the message w/i the width
#     - set @message to msg.center(width)

class Banner
  # base_case
  # def initialize(message)
  #   @message = message
  # end

  # further_exploration
  MAX_WIDTH = 76
  def initialize(message, width = 0)
    # puts "message.size is #{message.size}, width is #{width}"
    message = "message is too long !" if message.size > MAX_WIDTH
    if width == 0 || width < message.size
      @message = message
    else
      width = MAX_WIDTH if width > MAX_WIDTH
      @message = message.center(width)
    end
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    '+' + '-' * (@message.size + 2) + '+'
    # "+#{'-' * (@message.size + 2)}+"
  end

  def empty_line
    '|' + ' ' * (@message.size + 2) + '|'
    # "|#{' ' * (@message.size + 2)}|"
  end

  def message_line
    "| #{@message} |"
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner
=begin
+--------------------------------------------+
|                                            |
| To boldly go where no one has gone before. |
|                                            |
+--------------------------------------------+
=end
# banner = Banner.new('To boldly go where no one has gone before, now, hereafter, never, or never-ever-not-ever.')
# puts banner
# banner = Banner.new('To boldly go where no one has gone before.', -1)
# puts banner
# banner = Banner.new('To boldly go where no one has gone before.', 0)
# puts banner
# banner = Banner.new('To boldly go where no one has gone before.', 1)
# puts banner
# banner = Banner.new('To boldly go where no one has gone before.', 42)
# puts banner
# banner = Banner.new('To boldly go where no one has gone before.', 43)
# puts banner
# banner = Banner.new('To boldly go where no one has gone before.', 44)
# puts banner
# banner = Banner.new('To boldly go where no one has gone before.', 60)
# puts banner
# banner = Banner.new('To boldly go where no one has gone before.', 100)
# puts banner

banner = Banner.new('')
puts banner
=begin
+--+
|  |
|  |
|  |
+--+
=end
