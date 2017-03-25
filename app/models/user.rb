class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true
  validates :username, length: {minimum: 4}
  validates :password, length: {minimum: 8}

  has_many :video_posts
  has_many :video_comments, dependent: :destroy
  has_many :upvotes

  mount_uploader :profile_photo, ProfilePhotoUploader
end
