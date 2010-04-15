class Comment
  include ActiveModel::Serialization
  attr_accessor :date, :message, :user
  
  def initialize(attributes = {})
      attributes.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
  end
  
  def self.preCollect pst
    objects = []
    pst.each do |comment|
    
      objects << self.new(:date=>comment.at_css(".commentBy").text.gsub(/(.*), /, ""),
                          :message=>comment.at_css(".commentBlurb").text,
                          :user=>User.new(:name=>comment.at_css(".commentBy a").text, :url=>comment.at_css(".commentBy a")[:href], :icon=>comment.at_css(".commentImg img")[:src])
                          ) 
    
    end unless pst.empty?
    return objects
  end
  
  
end