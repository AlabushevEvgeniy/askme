class Hashtag < ApplicationRecord

  REGEXP = /#[[:word:]_]+/
  has_many :hashtags_questions, dependent: :destroy
  has_many :questions, through: :hashtags_questions

  before_validation :downcase
  validates :name, uniqueness: true

  scope :with_questions, -> { joins(:questions).where.not(questions: {id: nil}).uniq }

  def to_param
    name
  end

  def downcase
    self.name.downcase!
  end
end
