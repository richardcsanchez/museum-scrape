require_relative "../lib/scraper.rb"
require_relative "../lib/museums.rb"
require_relative "../lib/cli.rb"
#require_relative "..config/environment.rb"

require 'colorize'


class CLI
  BASE_PATH = "https://www.cntraveler.com"
  attr_accessor :museum_list_url

  def run
    make_museums #Start the scrape
    puts "Welcome to your NYC Museum Guide!".bold.colorize(:yellow)
    until @input == "exit" #begins loop listing museums and asking for input
      puts "Here's NYC's 25 Best Museums:".bold.colorize(:yellow)
      list_museums #list museum object name
      museum_details #finds and outputs chosen museum details
      puts " "
      puts "Want to learn about another museum? Type 'Yes'".bold
      puts "Type Exit to leave menu.".bold
      @input = gets.chomp
      if @input.capitalize == "Exit" #allows user to exit loop
      break
    elsif @input.capitalize != "Yes"
      puts " "
      puts "Hmm thats not right... But let's learn more anyway!".colorize(:pink).bold
      puts " "
    end
  end
  end

  def make_museums #scrapes page and creates museum objects array
    museum_array = Scraper.scrape_index_page(BASE_PATH + "/gallery/best-museums-in-new-york-city")
    Museum.create_from_array(museum_array)
  end

  def list_museums #sorts museums into alphabetical list and with index
    museum_alphabetical = Museum.all.sort_by {|museum| museum.name}
    museum_alphabetical.each.with_index(1) {|museum, index| puts  "#{index}. #{museum.name}"}
  end

  def museum_details #receives user choice and outputs chosen museum's decription and website
    puts "Please enter the number of the museum you would like to learn more about:".bold.colorize(:yellow)
    input = gets.chomp.to_i
      if (1..25).include?(input)
        @chosen_museum = Museum.all.sort_by {|museum| museum.name}[input - 1]
        puts " "
        puts "#{@chosen_museum.name}".bold.colorize(:blue)
        puts "#{@chosen_museum.museum_description}"
        puts " "
        puts "Want to learn even more? Visit the Museum Page!".bold
        puts "#{@chosen_museum.museum_site_url}".underline
      elsif (1..25).include?(input) == false
        puts " "
        puts "Hmm... That's not right.".colorize(:red).bold
      end
  end

end
