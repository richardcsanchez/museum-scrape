require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  index_url = "https://www.cntraveler.com/gallery/best-museums-in-new-york-city"

  def scrape_index_page(index_url)
    index = Nokogiri::HTML(index_html)
    museum = index.css(".image-content-container")
    museums = []
    museum.collect do |museum_content|
    museums << {
      :name => museum_content.css(".h2.hed").text
      :museum_profile_url => museum_content.css.("a").attribute("href").value
      }
end
