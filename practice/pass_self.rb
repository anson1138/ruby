class Trip
  def initialize
    @trips = "hong kong"
    puts "hi init #{self}"
  end

  def prepare_trip
    mechanic = Mechanic.new
    mechanic.prepare_trip(self)
  end

  def do_something
    puts "hi i'm part of trip"
  end

  def list_of_bikes
    ['trek', 'specialized', 'schwinn']
  end
end

class Mechanic
  def prepare_trip(something)
    puts something
    something.do_something
    bikes = something.list_of_bikes
    bikes.each do |bike| 
      puts "#{bike} hi mmommy"
    end
  end
end

def main
  trip = Trip.new
  trip.prepare_trip

end

main
