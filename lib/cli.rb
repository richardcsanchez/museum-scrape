require_relative "../lib/scraper.rb"
require_relative "../lib/museums.rb"


class CLI
  #BASE_PATH = " "
  def run
    #Start the scrape
    @museum_objects = Scraper.new.scrape_index_page
    #list museum object name
    #ask user for input
  end

end
