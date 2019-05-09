class Question < ApplicationRecord

  has_many :hashtags_questions, foreign_key: 'question_id'
  has_many :hashtags, through: :hashtags_questions, dependent: :destroy

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true, foreign_key: 'author_id'

  validates :text, :user, presence: true
  validates :text, length: {maximum: 255}

  before_save :scan_hashtags
  before_update :destroy_hashtags_questions

  private

  def scan_hashtags
    #удаляем старые связи вопроса с его хэштэгами
    hashtags_questions.clear if @question.present?
    # @question.hashtags_questions.destroy_all if @question.present?

    "#{text} + #{answer}".scan(Hashtag::REGEXP).uniq.each do |name|
      hashtags << Hashtag.find_or_create_by!(name: name.delete("#"))
    end
  end

  def destroy_hashtags_questions
    hashtags_questions.clear if @question.present?
  end
end
