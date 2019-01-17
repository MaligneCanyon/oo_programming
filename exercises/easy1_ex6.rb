class Flight
  # attr_accessor :database_handle # don't provide access unless req'd

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

fly_high = Flight.new(1000)
