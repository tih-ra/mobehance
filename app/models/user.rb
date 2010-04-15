class User
  include ActiveModel::Serialization
  attr_accessor :name, :url, :icon, :location, :personal_url
  def initialize(attributes = {})
      attributes.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
  end
  
  def self.one doc, user_id
    self.new(:name=>doc.at_css("#info-head-wrap #username-info").text,
                          :url=>user_id,
                          :icon=>doc.at_css("#info-head-wrap #user-image img")[:src],
                          :location=>doc.at_css("#info-top-wrap div a").text,
                          :personal_url=>doc.at_css("#url-info a")[:href]
                          )
  end
  
end