class HashtagsQuestion < ApplicationRecord
  belongs_to :hashtag
  belongs_to :question#, optional: true

  validates :hashtag_id, uniqueness: {scope: :question_id}
end
