require_relative "../config/environment.rb"

class CLI
  BASE_PATH = "https://www.cntraveler.com"
  attr_accessor :museum_list_url

  def run
    make_museums
    puts "Welcome to your NYC Museum Guide!".bold.colorize(:yellow)
    puts " "
    puts "Want to learn about museums? Type 'Yes'".bold
    puts "Type 'Exit' to leave program."
    input = gets.chomp
    if input.capitalize != "Exit"
      user_input_loop
    end
  end

  def user_input_loop
    loop do
      puts " "
      puts "Here's NYC's 25 Best Museums:".bold.colorize(:yellow)
      list_museums
      museum_details
      puts " "
      puts "Want to learn about another museum? Type 'Yes'".bold
      puts "Type 'Exit' to leave menu."
      input = gets.chomp
      if input.capitalize == "Exit"
        break
      elsif input.capitalize != "Yes"
        puts " "
        puts "Hmm thats not right... But let's learn more anyway!".colorize(:magenta).bold
        puts " "
      end
    end
  end

  def make_museums
    museum_array = Scraper.scrape_index_page(BASE_PATH + "/gallery/best-museums-in-new-york-city")
    Museum.create_from_array(museum_array)
  end

  def list_museums
    museum_alphabetical = Museum.all.sort_by {|museum| museum.name}
    museum_alphabetical.each.with_index(1) {|museum, index| puts  "#{index}. #{museum.name}"}
  end

  def museum_details 
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
