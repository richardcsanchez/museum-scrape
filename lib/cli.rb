require_relative "../lib/scraper.rb"
require_relative "../lib/museums.rb"
require_relative "../lib/cli.rb"
require 'colorize'


class CLI
  BASE_PATH = "https://www.cntraveler.com/"
  attr_accessor :museum_list_url

  def run
    make_museums #Start the scrape
    puts "Welcome to your NYC Museum Guide!".bold.colorize(:yellow)
    puts "Here's NYC's 25 Best Museums:".bold.colorize(:yellow)
      list_museums #list museum object name
    museum_details
  end

  def make_museums
    @museum_array = Scraper.scrape_index_page(BASE_PATH + "/gallery/best-museums-in-new-york-city")
    Museum.create_from_array(@museum_array)
  end

  def list_museums
    museum_alphabetical = Museum.all.sort_by {|museum| museum.name}
    museum_alphabetical.each.with_index(1) do |museum, index|
      puts  "#{index}. #{museum.name}"
    end
  end

  def museum_details
    puts "Please enter the number of the museum you would like to learn more about".bold.colorize(:yellow)
      input = gets.chomp.to_i
      if (1..25).include?(input)
        chosen_museum = Museum.all.sort_by {|museum| museum.name}[input - 1]
        puts "#{chosen_museum.name}".bold.colorize(:blue)
        puts "#{chosen_museum.museum_description}"
      end
    end


end
