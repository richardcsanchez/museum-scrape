require_relative "../lib/scraper.rb"
require_relative "../lib/museums.rb"
require_relative "../lib/cli.rb"


class CLI
  BASE_PATH = "https://www.cntraveler.com/"
  attr_accessor :museum_list_url

  def run
    #Start the scrape
    make_museums
    museum_names
    list_museum_name
    #list museum object name
    #ask user for input
  end

  def make_museums
    @museum_array = Scraper.scrape_index_page(BASE_PATH + "/gallery/best-museums-in-new-york-city")
    Museum.create_from_array(@museum_array)
  end

  def list_museum_name
    Museum.all.each do |key, value|
      puts "#{key}"
    end
    end

end
