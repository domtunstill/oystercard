require 'csv'

class Station
  attr_reader :name, :zone

  def initialize(name)
    @name = name
    zone
  end

  def zone 
    CSV.foreach('london_stations.csv') do |row|
      return @zone = row[5].to_i if row[0].downcase == @name.downcase
    end
  end

end