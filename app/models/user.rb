class User
  include ActiveModel::Serialization
  attr_accessor :name, :url, :icon, :location, :personal_url
  def initialize(attributes = {})
      attributes.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
  end
  
  def self.one doc, user_id
    self.new(:name=>doc.at_css("#block-profile-info .block-title").text,
                          :url=>user_id,
                          :icon=>doc.at_css("#block-profile-info .block-content img")[:src],
                          :location=>doc.at_css("#profile-details .profile-section[2] .block-profile-basic li[2] a").text,
                          :personal_url=>doc.at_css("#profile-details .profile-section[2] .block-profile-basic li[3] a")[:href],
                          )
  end
  
end