class Question < ApplicationRecord

  has_many :hashtags_questions
  has_many :hashtags, through: :hashtags_questions

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true#, foreign_key: 'author_id'

  validates :text, :user, presence: true
  validates :text, length: {maximum: 255}
end
