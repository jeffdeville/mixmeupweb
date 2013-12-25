class RenameDrinksIdInPhotos < ActiveRecord::Migration
  def change
    rename_column :photos, :drinks_id, :drink_id
  end
end
