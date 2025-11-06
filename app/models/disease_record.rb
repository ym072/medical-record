class DiseaseRecord < ApplicationRecord
  belongs_to :kid
  has_many :reported_symptoms, dependent: :destroy
  validates :start_at, presence: true
end
