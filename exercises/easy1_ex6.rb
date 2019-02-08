class Flight
  # attr_accessor :database_handle # don't provide access unless req'd

  def initialize(flight_number)
    @database_handle = Database.init # actual way to initialize a DB in R. ?
    @flight_number = flight_number
  end
end
