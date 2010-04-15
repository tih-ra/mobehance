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
    doc.css("#{type=='users' ? '#profile-projects' : '#gallery-row-list'} .coverWrapper").each do |item|
      
      proj_url = item.at_css(".coverImg a")[:href].gsub('/Gallery/', '')
      cover_src = item.at_css(".coverImg img")[:src]
      title = item.at_css(".projectName").text
      
      db_project = DbProject.find_or_create_by_url(proj_url)
      db_project.preCreate({:cover_src=>cover_src, :title=>title})
      
      objects << self.new(:title=>title, 
                          :cover=>cover_src, 
                          :date=>( item.at_css(".coverDate").nil? ? '' : item.at_css(".coverDate").text ),
                          :url=>proj_url, 
                          :user=>User.new(:name=>item.at_css(".coverBy a").text, :url=>item.at_css(".coverBy a")[:href].gsub(Behance::BehanceDomain,'')),
                          :categories=>Category.preCollect(item.css(".coverRealmBg a"))
                          )
    end
    return objects
  end
  
  def self.one doc, proj_url
    
    self.new(:title=>doc.at_css("#proj-info h1").text,
                          :date=>doc.at_css("#proj-info-stats div[2] span").text,
                          :user=>User.new(:name=>doc.at_css("#project-owners a").text, :url=>doc.at_css("#project-owners a")[:href]),
                          :categories=>Category.preCollect(doc.css("#tag_links a")),
                          :items=>Item.preCollect(doc.css("#proj-body div img"), proj_url)
                          )
  end
  
  def self.comments doc, proj_id
    self.new(:title=>doc.at_css("#proj-info h1").text,
                          :proj_id=>proj_id,
                          :date=>doc.at_css("#proj-info-stats div[2] span").text,
                          :user=>User.new(:name=>doc.at_css("#project-owners a").text, :url=>doc.at_css("#project-owners a")[:href]),
                          :comments=>Comment.preCollect(doc.css("#commentsAjax .commentMod"))
                          )
    
  end
  
end