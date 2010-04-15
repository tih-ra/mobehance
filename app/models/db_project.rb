class DbProject < ActiveRecord::Base
  has_many :db_photos, :dependent=>:destroy
  has_many :db_favorites, :dependent=>:destroy
  
  def getImages pst
    if (self.db_photos.empty?)
      pst.each do |item|
        _src = item[:src]
        self.db_photos.create(:image_url=>_src) unless _src.nil?
      end
    end
    self.db_photos
  end
  
  def preCreate obj = {}
    if (self.cover_src.blank?)
      self.cover_src = obj[:cover_src]
      self.title = obj[:title]
      self.save
    end
  end
end
