class AddTitleAndCoverSrcToDbProject < ActiveRecord::Migration
  def self.up
    add_column :db_projects, :title, :string
    add_column :db_projects, :cover_src, :string
  end

  def self.down
    remove_column :db_projects, :cover_src
    remove_column :db_projects, :title
  end
end
