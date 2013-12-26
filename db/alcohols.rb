require 'csv'

def load_alcohols
  Alcohol.delete_all
  CSV.foreach(File.join(Rails.root, "db", "alcohols.csv"), {headers: :first_row}) do |alcohol_data|
    Alcohol.find_or_create_by(name: alcohol_data[0], is_primary: alcohol_data[3], proof: alcohol_data[2])
  end
end
# [
#   ["Vodka",         true, 40],
#   ["Gin",            true, 38],
#   ["Rum",            true, 48],
#   ["Tequila",        true, 45],
#   ["Scotch",         true, 100],
#   ["Bourbon",        true, 65],
#   ["Sambuca",        false, 40],
#   ["Kahlua",         false, 27],
#   ["Jagermeister",   true, 35],
#   ["Brandy",         true, 40],
#   ["Whiskey",        true, 45],
#   ["Champagne",      true, ],
#   ["Cognac",         false, ],
#   ["Cointreau",      false, 40],
#   ["Everclear",      false, 80],
#   ["Schnapps",       false, 30]
# ].each do |alcohol_data|
#   name, is_primary, proof = *alcohol_data
#   Alcohol.find_or_create_by(name: name, is_primary: is_primary, proof: proof)
# end
