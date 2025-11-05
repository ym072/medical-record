class Kid < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 50 }

  validates :birthday, presence: true
end
