# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects ={}
  info= kickstarter.css('.grid_4')
  individual_info = kickstarter.css('.project-card')
  individual_info.each{|project|
  name = project.css('.bbcard_name strong').text.strip
  image_link = project.css('.project-thumbnail').css('a').css('.projectphoto-little').first.attributes["src"].value
  location =project.css('.project-meta').css('.location-name').text
  description =project.css('.bbcard_blurb').text.strip
  percent_funded = project.css('.funded').css('strong').text
  percent_funded = percent_funded.gsub('%','').to_i
      projects["#{name}"] = {
      :image_link => image_link,
      :description => description,
      :location => location,
      :percent_funded => percent_funded}
  }
  # binding.pry
  projects
end







# :projects => {
#   "My Great Project"  => {
#     :image_link => "Image Link",
#     :description => "Description",
#     :location => "Location",
#     :percent_funded => "Percent Funded"
#   },
#   "Another Great Project" => {
#     :image_link => "Image Link",
#     :description => "Description",
#     :location => "Location",
#     :percent_funded => "Percent Funded"
#   }
# }