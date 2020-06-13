require 'pry'
require 'nokogiri'


def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects = {}

  kickstarter.css(".project-card").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text.strip,
      :location => project.css("ul.project-meta li a").first.text.strip,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%", " ").to_i
    }
  end

projects
end



# projects: kickstarter.css("li.project.grid_4")
# or kickstarter.css(".project-card").first.css("h2").text
# project.css("h2.bbcard_name strong a").first.text


# to get image file
# project.css("div.project-thumbnail a img").attribute("src").value

# to get descriptions
# project.css("p.bbcard_blurb").first.text

# to get the location
# project.css("ul.project-meta li a").first.text

# project.css("ul.project-stats li.first.funded strong").first.text
# this will return "77%". if do without strong, will return "77% funded"
# project.css("ul.project-stats li.first.funded strong").text.gsub("%", " ").to_i
# will return an integer of 77

# project.css("ul.project-stats li.pledged strong").first.text
# this will return how much money have been pledged