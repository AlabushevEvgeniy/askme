class Question < ApplicationRecord

  has_many :hashtags_questions, dependent: :destroy
  has_many :hashtags, through: :hashtags_questions

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true, foreign_key: 'author_id'

  validates :text, :user, presence: true
  validates :text, length: {maximum: 255}

  before_save :scan_hashtags

  private

  def scan_hashtags
    #удаляем старые связи вопроса с его хэштэгами
    hashtags_questions.clear

    "#{text} + #{answer}".scan(Hashtag::REGEXP).uniq.each do |name|
      hashtags << Hashtag.find_or_create_by!(name: name.downcase)
    end
  end
end
