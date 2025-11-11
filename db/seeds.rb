# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
symptom_names = [
  "頭痛",
  "咳",
  "鼻水",
  "発疹",
  "嘔吐",
  "便",
  "その他"
]

symptom_names.each do |name|
  SymptomName.find_or_create_by!(name: name)
end

puts "症状名データを登録しました（#{SymptomName.count}件）"

puts "登録済みの症状名一覧："
SymptomName.pluck(:name).each { |n| puts " - #{n}" }
