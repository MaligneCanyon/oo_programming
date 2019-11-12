require 'pry'

class Customer
  @@number = 0

  attr_accessor :order

  def initialize
    @name = nil
    @number = nil
    @order = nil # current Order obj
    @orders = [] # a history (arr) of Order objs
  end

  def get_name
    response = nil
    counter = 0
    loop do
      puts "Please tell me your name:"
      response = gets.chomp
      if counter > 1
        @@number += 1
        number = @@number # private setter method
        name = @@number.to_s # private setter method
        break
      end
      exit if response == 'exit' # a way out ...
      unless response == ''
        name = response # private setter method
        print "Hi #{response} !  "
        # unless name found in list of customers, assign a custom number
        break
      end
      counter += 1
    end
    print "Customer 'name' is #{name}, number is #{@number} ..."
  end

  def get_order
    self.order = Order.new
    order.take
  end

  def review_order
    order.review
  end

  def calc_total
    order.total
    order.display_payment_message
  end

  def place_order
    order.place
  end

  private
  attr_accessor :name, :number
end


class Order
  attr_accessor :total_cost

  def initialize
    @burger = Burger.new
    @side = Side.new
    @drink = Drink.new
    @total_cost = nil
  end

  def take
    puts "Can I please take your order ?"
    # mapped_meal = meal.map do |item|
    #   item.choose_option
    #   item.to_s
    # end
    # p mapped_meal
    meal.each { |item| item.choose_option }
  end

  def total
    # total_cost = @burger + @side + @drink
    self.total_cost = meal.map(&:cost).sum
  end

  def review
    puts "So, that's an #{self}."
  end

  def display_payment_message
    puts "Please pay $#{format("%.2f", total)}."
  end

  def place
    puts "Placing order now ..."
  end

  def meal
    [@burger, @side, @drink]
  end

  def to_s
    meal.map(&:to_s).join(', ')
  end
end


class MealItem
  attr_accessor :option

  def choose_option
    options = self.class::OPTIONS
    arr = options.map { |k, v| [k, v[:name]] }
    loop do
      puts "Please choose a #{self.class.name} option from:"
      arr.each { |option| puts "  #{option.first} => #{option.last}" }
      self.option = gets.chomp
      break if options.keys.include?(option)
      print "That's not a valid choice: "
    end
  end

  def cost
    self.class::OPTIONS[option][:cost]
  end

  def to_s # rtn a str that is the value of an option
    self.class::OPTIONS[@option][:name]
  end
end

class Burger < MealItem
  OPTIONS = {
    '1' => { name: 'LS Burger', cost: 3.00 },
    '2' => { name: 'LS Cheeseburger', cost: 3.50 },
    '3' => { name: 'LS Chicken Burger', cost: 4.50 },
    '4' => { name: 'LS Double Deluxe Burger', cost: 6.00 }
  }
end

class Side < MealItem
  OPTIONS = {
    '1' => { name: 'Fries', cost: 0.99 },
    '2' => { name: 'Onion Rings', cost: 1.50 }
  }
end

class Drink < MealItem
  OPTIONS = {
    '1' => { name: 'Cola', cost: 1.50 },
    '2' => { name: 'Lemonade', cost: 1.50 },
    '3' => { name: 'Vanilla Shake', cost: 2.00 },
    '4' => { name: 'Chocolate Shake', cost: 2.00 },
    '5' => { name: 'Strawberry Shake', cost: 2.00 }
  }
end


class LSB
  def initialize
    init_totals
  end

  def begin_shift
    loop do
      display_welcome_message
      customer = Customer.new
      customer.get_name
      customer.get_order
      customer.review_order
      customer.calc_total
      customer.place_order
      display_goodbye_message
    end
  end

  def init_totals
    @monetary_total = 0
    @product_totals = []
  end

  def display_welcome_message
    puts "Welcome to LSB !  Can I take your order ?"
  end

  def display_goodbye_message
    puts "Enjoy your meal !"
    puts
  end

  def end_shift
    calc_monetary_totals
    calc_product_totals
  end
end

LSB.new.begin_shift
