class CreateDbProjects < ActiveRecord::Migration
  def self.up
    create_table :db_projects do |t|
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :db_projects
  end
end
