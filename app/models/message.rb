class Message < ApplicationRecord
  belongs_to :parent, foreign_key: :parent_id, class_name: 'Message', optional: true
  belongs_to :from, foreign_key: :from_id, class_name: 'User'
  belongs_to :to, foreign_key: :to_id, class_name: 'User'
  has_many :folders, dependent: :destroy
  has_many :categories, through: :folders
  validates :content, :subject, presence: true
  validates :from, :to, presence: true

  def name_from
    self.from.username
  end

  def name_to
    self.to.username
  end

  after_create do
    Folder.create(message: self, category: Category.find_by(user: self.from, name: "Sent"), user: self.from)
    Folder.create(message: self, category: Category.find_by(user: self.to, name: "Inbox"), user: self.to)
  end

  def replies
    Message.where(parent_id: id)
  end
end
