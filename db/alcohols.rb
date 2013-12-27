require 'csv'

def load_alcohols
  Alcohol.delete_all
  CSV.foreach(File.join(Rails.root, "db", "alcohols.csv"), {headers: :first_row}) do |alcohol_data|
    alcohol = Alcohol.find_or_create_by(name: alcohol_data[0])
    alcohol.is_primary = alcohol_data[3]
    alcohol.proof = alcohol_data[2]
    alcohol.search_terms = alcohol_data[4].split("|")
    alcohol.save!
  end
end
