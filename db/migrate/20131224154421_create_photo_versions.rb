class CreatePhotoVersions < ActiveRecord::Migration
  def change
    create_table :photo_versions do |t|
      t.references :photo
      t.string :url
      t.integer :height
      t.integer :width
    end

    remove_column :photos, :type
    remove_column :photos, :url
    remove_column :photos, :height
    remove_column :photos, :width
  end
end
