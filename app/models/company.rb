class Company < ApplicationRecord
  has_many :users

  validates :name, presence: true
  validates :name, uniqueness: true

  scope :search, ->(query) {
    where("name LIKE ?", "%#{query}%") if query.present?
  }
  
end
