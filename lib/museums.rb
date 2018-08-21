require_relative "../lib/scraper.rb"
require_relative "../lib/museums.rb"
require_relative "../lib/cli.rb"
require 'pry'

class Museum

  attr_accessor :name, :museum_site_url, :museum_description

  @@all = []

  def initialize(museum_hash)
    museum_hash.each_pair {|key, value| self.send(("#{key}="), ("#{value}"))}
      @@all << self
    end

    def self.create_from_array(museum_array)
      museum_array.each { |student_hash| self.new(student_hash)}
    end

    def self.all
      @@all
    end




end
