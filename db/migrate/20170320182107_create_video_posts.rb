class CreateVideoPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :video_posts do |t|
      t.references :user, foreign_key: true
      t.boolean :is_approved, default: false
      t.integer :is_meh, default: 0
      t.integer :is_ok, default: 0
      t.integer :i_like_it, default: 0

      t.timestamps
    end
  end
end
