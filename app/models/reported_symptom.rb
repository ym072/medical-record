class ReportedSymptom < ApplicationRecord
  belongs_to :disease_record
  belongs_to :symptom_name
end
