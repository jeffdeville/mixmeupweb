require 'csv'

def load_alcohols
  Alcohol.delete_all
  CSV.foreach(File.join(Rails.root, "db", "alcohols.csv"), {headers: :first_row}) do |alcohol_data|
    Alcohol.find_or_create_by(name: alcohol_data[0], is_primary: alcohol_data[3], proof: alcohol_data[2])
  end
end
