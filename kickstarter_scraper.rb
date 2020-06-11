require "nokogiri"

def create_project_hash

  html = File.read("./fixtures/kickstarter.html")
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css("#projects_list .project-card").each do |project_data|
    projects[project_data.css("h2 a").text.strip.to_sym] = {
      image_link: project_data.css("img").attribute("src").value,
      description: project_data.css("p.bbcard_blurb").text.strip,
      location: project_data.css("span.location-name").text.strip,
      percent_funded: project_data.css("li.first.funded strong").text.strip.gsub("%","").to_i
    }
  end

  projects

end