require 'nokogiri'
require 'open-uri'
require 'pry'
require 'httparty'
require_relative "../lib/museums.rb"
require_relative "../lib/cli.rb"

class Scraper

  attr_accessor :museum_list_url

   BASE_PATH = "https://www.cntraveler.com" #original website
   museum_list_url = (BASE_PATH + "/gallery/best-museums-in-new-york-city")
    #combines original website with specific list page BASE_PATH and list page
    #are separated to allow museum site urls to be created

  def self.scrape_index_page(museum_list_url) #scrapes museum list site
      doc = HTTParty.get(museum_list_url)
      index = Nokogiri::HTML(doc)
      scraped_museums = index.css(".gallery-item.gallery-item-venue")
      museum_hash = []
      scraped_museums.collect do |museum_content|
        museum_hash << {
          :name => museum_content.css("h2.hed").text,
          :museum_site_url => BASE_PATH + museum_content.css("a").attribute("href").value,
          :museum_description => museum_content.css("div.dek").css("p").text
        }
      end
      museum_hash #returns collection of scraped museums with attributes
    end


  # def self.scrape_museum_page(museum_site_url)
  #   museum_html = HTTParty.get(museum_site_url)
  #   museum_index = Nokogiri::HTML(museum_html)
  #   museum_details = {}
  #   museum_index.css("div.venue-grid-wrapper.name-info").each do |museum_page_header|
  #     museum_details << {
  #       :name => museum_page_header.css("h1"),
  #       :short_description => museum_page_header.css("div")
  #     }
  #   end
  #   museum_details
  #   binding.pry
  # end

end
