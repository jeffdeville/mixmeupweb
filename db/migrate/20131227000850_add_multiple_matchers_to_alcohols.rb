class AddMultipleMatchersToAlcohols < ActiveRecord::Migration
  def change
    add_column :alcohols, :search_terms, :string, array: true
  end
end
