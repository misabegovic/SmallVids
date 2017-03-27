class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :subject
      t.text :content
      t.integer :from_id
      t.integer :to_id
      t.integer :parent_id

      t.timestamps
    end
  end
end
