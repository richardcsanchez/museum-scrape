require_relative "../lib/scraper.rb"
require_relative "../lib/museums.rb"
require_relative "../lib/cli.rb"
require 'pry'

class Museum

  attr_accessor :name, :museum_site_url, :museum_description

  @@all = []

  def initialize(museum_collection)
    #binding.pry
    museum_collection.each_pair {|key, value| self.send(("#{key}="), ("#{value}"))}
      @@all << self
    end

    def self.create_from_array(museum_array)
      museum_array.each { |museum_hash| self.new(museum_hash)}
    end

    def self.all
      @@all
    end

end
