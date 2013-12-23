class AddAlcohols < ActiveRecord::Migration
  def change
    create_table :alcohols do |t|
      t.string :name
      t.boolean :is_primary
    end
  end
end
