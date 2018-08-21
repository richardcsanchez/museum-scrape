require 'nokogiri'
require 'open-uri'
require 'pry'
require 'httparty'
require_relative "../lib/museums.rb"
require_relative "../lib/cli.rb"

class Scraper

   BASE_PATH = "https://www.cntraveler.com/"
   @museum_list_url = (BASE_PATH + "/gallery/best-museums-in-new-york-city")

  def self.scrape_index_page(museum_list_url)
      doc = HTTParty.get(museum_list_url)
      index = Nokogiri::HTML(doc)
      @scraped_museums = index.css(".gallery-item.gallery-item-venue")
      museum_objects_collection = []
      @scraped_museums.collect do |museum_content|
        museum_objects_collection << {
          :name => museum_content.css("h2.hed").text,
          :museum_page_url => museum_content.css("a").attribute("href").value
        }
      end
      museum_objects_collection
    end


  # def self.scrape_museum_page(museum_page_url)
  #   museum_html = open(profile_url)
  #   museum_index = Nokogiri::HTML(museum_html)
  #   museum_details = {}
  # end

end
