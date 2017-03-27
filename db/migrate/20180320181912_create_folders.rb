class CreateFolders < ActiveRecord::Migration[5.0]
  def change
    create_table :folders do |t|
      t.references :user, foreign_key: true
      t.belongs_to :message, index: true
      t.belongs_to :category, index: true
    end
  end
end
