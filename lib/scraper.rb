require_relative "../config/environment.rb"

class Scraper

  attr_accessor :museum_list_url

   BASE_PATH = "https://www.cntraveler.com"
   museum_list_url = (BASE_PATH + "/gallery/best-museums-in-new-york-city")

  def self.scrape_index_page(museum_list_url) 
      doc = HTTParty.get(museum_list_url)
      index = Nokogiri::HTML(doc)
      scraped_museums = index.css(".gallery-item.gallery-item-venue")
      scraped_museums.collect do |museum_content|
         {
          :name => museum_content.css("h2.hed").text,
          :museum_site_url => BASE_PATH + museum_content.css("a").attribute("href").value,
          :museum_description => museum_content.css("div.dek").css("p").text
        }
      end
    end
end
