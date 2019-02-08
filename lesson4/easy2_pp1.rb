class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

oracle = Oracle.new # creates an instance of the Oracle class

oracle.predict_the_future # calls the ptf instance method, which
                          #   calls the choices method, which
                          #     rtns an arr
                          #   calls the sample method on the arr, which
                          #     rtns one of the strs (randomly selected) from the arr
                          #   concats the str "You will " and the str rtn'd from the arr
                          #   rtns the concat'd str
