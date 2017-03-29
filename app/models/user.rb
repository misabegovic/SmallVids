class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :username, length: {minimum: 4}
  validates :password, length: {minimum: 8}

  has_many :video_posts
  has_many :video_comments, dependent: :destroy
  has_many :upvotes
  has_many :favorites, dependent: :destroy
  has_many :categories
  has_many :messages, through: :categories
  has_many :folders

  mount_uploader :profile_photo, ProfilePhotoUploader

  after_create do
    Category.create(name: "Inbox", user_id: id)
    Category.create(name: "Sent", user_id: id)
  end
end
