class VideoPost < ApplicationRecord
  acts_as_taggable
  belongs_to :user
  has_many :video_comments, dependent: :destroy
  has_many :upvotes
  mount_uploader :uploaded_video, VideoUploader

  validates :uploaded_video, file_size: { less_than_or_equal_to: 10.megabytes }
  #validates :uploaded_video, file_content_type: { allow: ['video/mp4'] }
end
