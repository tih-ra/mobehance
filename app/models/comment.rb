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
      message = comment.search(".user-content").text
      excluded_div = comment.search(".user-content-date-header").text
      objects << self.new(:date=>comment.at_css(".wall-post-date").text.to_time.strftime("%Y/%m/%d %H:%M"),
                          :message=>message.gsub("#{excluded_div}", "").gsub(/\s/, ''),
                          :user=>User.new(:name=>comment.at_css(".user-content-date-header a").text, :url=>comment.at_css(".user-content-date-header a")[:href], :icon=>comment.at_css(".user-image img")[:src])
                          ) 
    
    end unless pst.empty?
    return objects
  end
  
  
end