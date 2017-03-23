class VideoComment < ApplicationRecord
  belongs_to :video_post
  belongs_to :user
  validates :content, presence: :true
end
