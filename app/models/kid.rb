class Kid < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 50 }

  validates :birthday, presence: true

  has_many :disease_records, dependent: :destroy
end
