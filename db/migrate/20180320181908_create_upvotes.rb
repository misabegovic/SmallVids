class CreateUpvotes < ActiveRecord::Migration[5.0]
  def change
    create_table :upvotes do |t|
      t.references :user, foreign_key: true
      t.references :video_post, foreign_key: true

      t.timestamps
    end
  end
end
