class Hashtag < ApplicationRecord

  REGEXP = /#[[:word:]_]+/
  has_many :hashtags_questions
  has_many :questions, through: :hashtags_questions

  validates :name, uniqueness: true

  def to_param
    name
  end
end
