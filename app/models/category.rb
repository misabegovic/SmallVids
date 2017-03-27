class Category < ApplicationRecord
  belongs_to :user
  has_many :folders
  has_many :messages, through: :folders
  validates :name, presence: true
end
