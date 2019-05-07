class CreateJoinTableHashtagsQuestion < ActiveRecord::Migration[5.2]
  def change
    create_join_table :hashtags, :questions do |t|
      t.index [:hashtag_id]
      t.index [:question_id, :hashtag_id], unique: true
    end
  end
end
