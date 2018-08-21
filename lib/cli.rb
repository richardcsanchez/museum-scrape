require_relative "../lib/scraper.rb"
require_relative "../lib/museums.rb"
require_relative "../lib/cli.rb"


class CLI
  BASE_PATH = "https://www.cntraveler.com/"
  attr_accessor :museum_list_url

  def run
    #Start the scrape
    make_museums
    list_museums
    #list museum object name
    #ask user for input
  end

  def make_museums
    @museum_array = Scraper.scrape_index_page(BASE_PATH + "/gallery/best-museums-in-new-york-city")
    Museum.create_from_array(@museum_array)
  end

  def list_museums
    Museum.all.each.with_index(1) do |museum, index|
      puts  "#{index}. #{museum.name}"
    end
  end


end
