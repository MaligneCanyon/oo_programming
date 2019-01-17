#     winner = if human.move > computer.move
#       'human'
#     elsif computer.move > human.move
#       'computer'
#     else
#       'tie'
#     end
#     hsh = {
#       'h' => human.move.value,
#       'c' => computer.move.value,
#       'w' => winner
#     }

# inputs:
# - arr of hshs
# outputs:
# - arr
# reqs:
# - given the indicated hsh (above)
#   - determine the % of times the computer wins for each of the move choices
#   - bias the computer choice proportionally
# rules:
# - one entry of each move choice in the sample arr for each % of times the computer
#   previously won for the choice
#   - ex. if r=2% p=6% s=5% l=4% S=1%
#         sample_arr = [
#           ['rock', 'rock'],
#           ['paper', 'paper', 'paper', 'paper', 'paper', 'paper'],
#           ['scissors', 'scissors', 'scissors', 'scissors', 'scissors'],
#           ['lizard', 'lizard', 'lizard', 'lizard'],
#           ['Spock']
#         ].flatten
# struct:
# - arr
# algo:
# - init a counter_hsh to {'r'=>0, 'p'=>0, 's'=>0, 'l'=>0, 'S'=>0}
#   - if the computer won
#     - if the computer chose 'r'
#       - incr the value for the 'r' key in the counter_hsh
#     - (repeat for other move choices)
# - init a sample_arr to []
# - for each key:value in the counter_hsh
#   - gen a new_arr containing 'value' number of 'key' strs
#   - save the new_arr in the sample_arr
# - flatten and rtn the sample_arr

def bias(arr)
  counter_hsh = {'rock'=>0, 'paper'=>0, 'scissors'=>0, 'lizard'=>0, 'Spock'=>0}
  arr.each { |elem| counter_hsh[elem['c']] += 2 if elem['w'] == 'computer' }
  # sample_arr = []
  # counter_hsh.each do |k, v|
  #   new_arr = Array.new(v) { k }
  #   sample_arr << new_arr
  # end
  # sample_arr.flatten
  counter_hsh.map { |k, v| Array.new(v) { k } }.flatten
end

p bias([
  {'h' => 'rock', 'c'=>'paper', 'w'=>'computer'},
  {'h' => 'paper', 'c'=>'rock', 'w'=>'human'},
  {'h' => 'lizard', 'c'=>'scissors', 'w'=>'computer'},
  {'h' => 'rock', 'c'=>'paper', 'w'=>'computer'},
])