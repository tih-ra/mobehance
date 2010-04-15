class CreateDbFavorites < ActiveRecord::Migration
  def self.up
    create_table :db_favorites do |t|
      t.string :behance_user
      t.integer :db_project_id

      t.timestamps
    end
  end

  def self.down
    drop_table :db_favorites
  end
end
