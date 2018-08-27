require_relative "../config/environment.rb"

class Museum

  attr_accessor :name, :museum_site_url, :museum_description

  @@all = []

  def initialize(museum_hash) # take in an argument of a hash and assigns the 
    #new museum attributes and values to match with the key/value pairs of the hash
    #and saves in @@all array. Send method dynamically calls on the attr_accessor methods
    #and creates key => value pairs
    museum_hash.each_pair {|key, value| self.send(("#{key}="), ("#{value}"))}
      @@all << self
    end

    def self.create_from_array(museum_array)
      #takes in array of hashes and iterated over them to create new individual museums
      museum_array.each { |museum_hash| self.new(museum_hash)}
    end

    def self.all
      @@all
    end

end
