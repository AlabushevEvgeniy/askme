class Hashtag < ApplicationRecord

  REGEXP = /#[[:word:]_]+/
  has_many :hashtags_questions, dependent: :destroy, foreign_key: 'hashtag_id'
  has_many :questions, through: :hashtags_questions

  validates :name, uniqueness: true

  def to_param
    name
  end
end
