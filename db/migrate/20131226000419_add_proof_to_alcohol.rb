class AddProofToAlcohol < ActiveRecord::Migration
  def change
    add_column :alcohols, :proof, :integer
  end
end
