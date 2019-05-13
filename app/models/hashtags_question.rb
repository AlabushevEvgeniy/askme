class HashtagsQuestion < ApplicationRecord
  belongs_to :hashtag
  belongs_to :question

  validates :hashtag_id, uniqueness: {scope: :question_id}
end
