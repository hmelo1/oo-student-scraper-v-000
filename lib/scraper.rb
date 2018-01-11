require "nokogiri"
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    #student: learnco.css("div.student-card").first
    #name: student.css("h4.student-name")
    #location: student.css("p.student-location")
    #profile_url: student.css("div.student-card a").attribute("href").value

    html = File.read(index_url)
    learnco = Nokogiri::HTML(html)
    students = []
    temp = {}
    learnco.css("div.student-card").each_with_index do |student, index|
      temp = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      students << temp
    end
    students
  end

  def self.scrape_profile_page(profile_url)
#
    html = File.read(profile_url)
    learnco = Nokogiri::HTML(html)
    links = {}
    learnco.css("div.social-icon-container a").each_with_index do |social_media, index|
      if social_media.attribute("href").value.include? "twitter"
        puts "TWITTER!"
        links[:twitter] = social_media.attribute("href").value
      end
    end
  end
end

#index_url = "./fixtures/student-site/index.html"
#Scraper.scrape_index_page(index_url)

profile_url = "./fixtures/student-site/students/ryan-johnson.html"
Scraper.scrape_profile_page(profile_url)

#test_url = "https://www.google.com/testing"
#test_url2 = "https://facebook.com/test"

#Scraper.strip_url(test_url)
#Scraper.strip_url(test_url2)

#learnco.css("div.social-icon-container")
#student.css("a").each do |link|
# => puts test.attribute("href").value
#end
