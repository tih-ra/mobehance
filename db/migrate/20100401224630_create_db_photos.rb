class CreateDbPhotos < ActiveRecord::Migration
  def self.up
    create_table :db_photos do |t|
      t.integer :db_project_id
      t.string :img_file_name
      t.string :img_content_type
      t.integer :img_file_size
      t.datetime :img_updated_at
      t.string :img_remote_url

      t.timestamps
    end
  end

  def self.down
    drop_table :db_photos
  end
end
