class RelateIngredientsToAlcohols < ActiveRecord::Migration
  def change
    add_column :ingredients, :alcohol_id, :integerl
  end
end
