require 'open-uri'
require 'pry'
require 'nokogiri'


class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    index_data = Nokogiri:: HTML(html)

    index_hashes_array = []
    big_hash = index_data.css("div.student-card").each do |single_bit|
      student_hash = {
      name: single_bit.css("h4.student-name").text,
      location: single_bit.css("p.student-location").text,
      profile_url: "./fixtures/student-site/" + single_bit.css("a").attribute("href").value
      }
      index_hashes_array.push(student_hash)
    end
    index_hashes_array
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile_data = Nokogiri:: HTML(html)

    profile_hash = {}

      #-----------Social Media ------------
      social_urls = []
      social_stuffs = profile_data.css("div.social-icon-container")
      # binding.pry
      social_stuffs.css("a").each do |hash|
        item = hash.attribute("href").value
        social_urls.push(item)
      end
      profile_hash[:twitter] = social_urls.find{|str| str.include?("twitter")} if social_urls.find{|str| str.include?("twitter")}
      profile_hash[:linkedin] = social_urls.find{|str| str.include?("linked")} if social_urls.find{|str| str.include?("linked")}
      profile_hash[:github] = social_urls.find{|str| str.include?("github")} if social_urls.find{|str| str.include?("github")}
      profile_hash[:blog] = social_urls.last if social_urls.find{|str| str.include?("twitter")} && social_urls.find{|str| str.include?("linked")} && social_urls.find{|str| str.include?("github")}
      # binding.pry
      #-----------End Social --------------
      profile_hash[:profile_quote] = profile_data.css("div.profile-quote").text
      profile_hash[:bio] = profile_data.css("div.details-container").css("div.bio-content").css("p").text

    profile_hash
  end

end
{:twitter=>nil, :linkedin=>"https://www.linkedin.com/in/david-kim-38221690", :github=>"https://github.com/davdkm", :blog=>"https://github.com/davdkm", :profile_quote=>"\"Yeah, well, you know, that's just, like, your opinion, man.\" - The Dude", :bio=>"I'm a southern California native seeking to find work as a full stack web developer. I enjoying tinkering with computers and learning new things!"}
{:linkedin=>"https://www.linkedin.com/in/david-kim-38221690", :github=>"https://github.com/davdkm", :profile_quote=>"\"Yeah, well, you know, that's just, like, your opinion, man.\" - The Dude", :bio=>"I'm a southern California native seeking to find work as a full stack web developer. I enjoying tinkering with computers and learning new things!"}
