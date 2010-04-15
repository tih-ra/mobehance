class Item
  include ActiveModel::Serialization
  attr_accessor :src, :type, :description
  
  def initialize(attributes = {})
      attributes.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
  end
  
  def self.preCollect pst, proj_url, my_host
    objects = []
    db_project = DbProject.find_or_create_by_url(proj_url)
    images = db_project.getImages(pst)
    images.each do |item|
     
      objects << self.new(:src=>'http://'+my_host+item.img.url(:android),
                          :type=>'image',
                          :description=>''
                          ) 
    
    end unless images.empty?
    return objects
  end
  
  
end