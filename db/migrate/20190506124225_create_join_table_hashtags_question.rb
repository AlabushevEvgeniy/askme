class CreateJoinTableHashtagsQuestion < ActiveRecord::Migration[5.2]
  def change
    create_table :hashtags_questions do |t|
      t.integer :hashtag_id
      t.integer :question_id

      t.index [:hashtag_id]
      t.index [:question_id, :hashtag_id], unique: true
    end
  end
end
