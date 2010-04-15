class DbFavorite < ActiveRecord::Base
  belongs_to :db_project
  attr_accessor :proj_url
  #before_save :b_save
  #def b_save
  #  self.db_project = DbProject.find_by_url(self.proj_url)
  #end
end
