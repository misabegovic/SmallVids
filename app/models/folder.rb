class Folder < ApplicationRecord
  belongs_to :message
  belongs_to :category
  belongs_to :user
end
