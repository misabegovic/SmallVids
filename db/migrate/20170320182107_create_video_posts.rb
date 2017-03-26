class CreateVideoPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :video_posts do |t|
      t.references :user, foreign_key: true
      t.boolean :is_approved, default: false

      t.timestamps
    end
  end
end
