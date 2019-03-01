class BankAccount
  attr_reader :balance

  def initialize(account_number, client)
    @account_number = account_number
    @client = client
    @balance = 0
  end

  def deposit(amount)
    if amount > 0
      self.balance += amount
      "$#{amount} deposited. Total balance is $#{balance}."
    else
      "Invalid. Enter a positive amount."
    end
  end

  # def withdraw(amount)
  #   if amount > 0
  #     success = (self.balance -= amount) # RHS always rtns a balance, so always evals to T
  #     # catch-22: we want to test for success before we w/d the amount
  #   else
  #     success = false
  #   end

  #   if success
  #     "$#{amount} withdrawn. Total balance is $#{balance}."
  #   else
  #     "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
  #   end
  # end

  def withdraw(amount)
    # if amount > 0 && balance >= amount
    if amount > 0 && valid_transaction?(balance - amount)
      self.balance -= amount
      "$#{amount} withdrawn. Total balance is $#{balance}."
    else
      "Invalid. Enter a positive amount less than or equal to current balance ($#{balance})."
    end
  end

  attr_writer :balance
  # irrespective of updating the instance var, setter methods always rtn their input arg
  # def balance=(new_balance)
  #   if valid_transaction?(new_balance)
  #     @balance = new_balance
  #     true # useless
  #   else
  #     false # useless
  #   end
  # end

  def valid_transaction?(new_balance)
    # new_balance > 0 # should be '>='
    new_balance >= 0
  end
end

# Example

account = BankAccount.new('5538898', 'Genevieve')

                          # Expected output:
p account.balance         # => 0
p account.deposit(50)     # => $50 deposited. Total balance is $50.
p account.balance         # => 50
p account.withdraw(80)    # => Invalid. Enter positive amount less than or equal to current balance ($50).
p account.balance         # => 50

p account.withdraw(51)    # => Invalid. Enter positive amount less than or equal to current balance ($50).
p account.balance         # => 50
p account.withdraw(49)    # => $49 withdrawn. Total balance is $1.
p account.balance         # => 1
p account.withdraw(-5)    # => Invalid. Enter positive amount less than or equal to current balance ($1).
p account.balance         # => 1
