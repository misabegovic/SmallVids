class Upvote < ApplicationRecord
  belongs_to :user
  belongs_to :video_post
end
