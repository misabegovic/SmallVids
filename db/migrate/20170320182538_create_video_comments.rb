class CreateVideoComments < ActiveRecord::Migration[5.0]
  def change
    create_table :video_comments do |t|
      t.text :content
      t.references :video_post, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
