class CreateDrinksTable < ActiveRecord::Migration
  def change
    create_table :drinks do |t|
      t.string :name
      # These are the query parameters that must be computed
      t.string :alcohols, array: true, default: []
      t.decimal :proof
      t.decimal :girliness
      t.integer :calories

      # This is just information to help display the drink
      t.string :instructions, array: true, default: []
      t.string :source
      t.string :source_id
      t.string :attribution_url
      t.string :attribution_text
      t.string :attribution_html

      t.timestamps
    end

    create_table :ingredients do |t|
      t.references :drinks
      t.string :units
      t.decimal :quantity

      t.timestamps
    end

    create_table :photos do |t|
      t.references :drinks
      t.integer :type # :thumb, :web, :large
      t.string :url
      t.integer :height
      t.integer :width

      t.timestamps
    end
  end
end
