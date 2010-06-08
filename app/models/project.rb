#require 'nokogiri'
#require 'open-uri'

class Project
  include ActiveModel::Serialization
  
  attr_accessor :title, :cover, :date, :url, :user, :categories, :items, :comments, :proj_id
  
  def initialize(attributes = {})
      attributes.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
  end
  
  
  
  def self.all doc, type="featured"
    objects = []
    doc.css("#projects-content .cover-body").each do |item|
      
      proj_url = item.at_css(".cover-img a")[:href].gsub('/gallery/', '')
      cover_src = item.at_css(".cover-img img")[:src]
      title = item.at_css(".projectName").text
      
      db_project = DbProject.find_or_create_by_url(proj_url)
      db_project.preCreate({:cover_src=>cover_src, :title=>title})
      
      objects << self.new(:title=>title, 
                          :cover=>cover_src, 
                          :date=>( item.at_css(".coverDate").nil? ? '' : item.at_css(".coverDate").text ),
                          :url=>proj_url, 
                          :user=>User.new(:name=>item.at_css(".single-owner a").text, :url=>item.at_css(".single-owner a")[:href].gsub(Behance::BehanceDomain,'')),
                          :categories=>Category.preCollect(item.css(".cover-field-wrap a"))
                          )
    end
    return objects
  end
  
  def self.one doc, proj_url, my_host
    
    self.new(:title=>doc.at_css("#proj-header h1").text,
                          :date=>doc.at_css("#proj-info-stats div[2] span").text,
                          :user=>User.new(:name=>doc.at_css("#owners a").text, :url=>doc.at_css("#project-owners a")[:href]),
                          :categories=>Category.preCollect(doc.css("#tag_links a")),
                          :items=>Item.preCollect(doc.css("#project-modules img"), proj_url, my_host)
                          )
  end
  
  def self.comments doc, proj_id
    self.new(:title=>doc.at_css("#proj-header h1").text,
                          :proj_id=>proj_id,
                          :date=>doc.at_css("#proj-info-stats div[2] span").text,
                          :user=>User.new(:name=>doc.at_css("#owners a").text, :url=>doc.at_css("#project-owners a")[:href]),
                          :comments=>Comment.preCollect(doc.css("#comments-list .comment"))
                          )
    
  end
  
end