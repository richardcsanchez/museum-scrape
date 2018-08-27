require_relative "../config/environment.rb"

class Museum

  attr_accessor :name, :museum_site_url, :museum_description

  @@all = []

  def initialize(museum_hash)
    #binding.pry
    museum_hash.each_pair {|key, value| self.send(("#{key}="), ("#{value}"))}
      @@all << self
    end

    def self.create_from_array(museum_array)
      museum_array.each { |museum_hash| self.new(museum_hash)}
    end

    def self.all
      @@all
    end

end
