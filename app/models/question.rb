class Question < ApplicationRecord

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true#, foreign_key: 'author_id'

  validates :text, :user, presence: true
  validates :text, length: {maximum: 255}
end
