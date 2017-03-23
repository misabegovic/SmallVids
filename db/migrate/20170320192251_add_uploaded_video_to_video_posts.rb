class AddUploadedVideoToVideoPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :video_posts, :uploaded_video, :string
  end
end
