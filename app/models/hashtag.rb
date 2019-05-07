class Hashtag < ApplicationRecord
  has_many :hashtags_questions
  has_many :questions, through: :hashtags_questions

  validates :name, uniqueness: true
end
