# we have 2 competing rescue clauses 'rescue1' and 'rescue2'; need to comment
# one of them out, or differentiate the error classes that they are rescuing

class AuthenticationError < Exception; end # should not rescue the Exception class ***

# A mock search engine
# that returns a random number instead of an actual count.
class SearchEngine
  def self.count(query, api_key)
    unless valid?(api_key)
      raise AuthenticationError, 'API key is not valid.'
    end

    rand(200_000)
  end

  private

  def self.valid?(key)
    # key == 'LS1A' ***
    key == ''
  end
end

module DoesItRock
  API_KEY = 'LS1A'

  class NoScore; end

  class Score
    def self.for_term(term)
      positive = SearchEngine.count(%{"#{term} rocks"}, API_KEY).to_f
      negative = SearchEngine.count(%{"#{term} is not fun"}, API_KEY).to_f

      positive / (positive + negative)
    rescue Exception # rescue1
      puts "in rescue1 mode"
      # NoScore # we need to return a class instance here
      NoScore.new
    end
  end

  def self.find_out(term)
    score = Score.for_term(term)
    p score == NoScore  # false
    p score === NoScore # false
    p NoScore === score # true; 'NoScore' is a group that 'score' belongs too

    case score
    when NoScore
      "No idea about #{term}..."
    when 0...0.45
      "#{term} is not fun."
    when 0.45..0.55
      "#{term} seems to be ok..."
    else
      "#{term} rocks!"
    end
  rescue Exception => e # rescue2
    # e.message
    e.message + ", in rescue2 mode"
  end
end

# Example (your output may differ)
puts DoesItRock.find_out('Sushi')
# puts DoesItRock.find_out('Rain')        # Rain is not fun.
# puts DoesItRock.find_out('Bug hunting') # Bug hunting rocks!
