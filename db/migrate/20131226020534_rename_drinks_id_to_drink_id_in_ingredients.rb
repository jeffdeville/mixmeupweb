class RenameDrinksIdToDrinkIdInIngredients < ActiveRecord::Migration
  def change
    rename_column :ingredients, :drinks_id, :drink_id
  end
end
