class Wallet
  include Comparable

  def initialize(amount)
    @amount = amount
  end

  def <=>(other_wallet)
    # other_wallet.amount has an explicit receiver (and we can't call a
    # private method w/ one), so ...
    amount <=> other_wallet.amount
  end

  protected
  attr_reader :amount # ... we must use a protected getter method
end

bills_wallet = Wallet.new(500)
pennys_wallet = Wallet.new(465)
if bills_wallet > pennys_wallet
  puts 'Bill has more money than Penny'
elsif bills_wallet < pennys_wallet
  puts 'Penny has more money than Bill'
else
  puts 'Bill and Penny have the same amount of money.'
end
