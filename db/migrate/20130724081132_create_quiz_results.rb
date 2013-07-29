class CreateQuizResults < ActiveRecord::Migration
  def change
    create_table :quiz_results do |t|
      t.integer :user_id
      t.integer :quiz_question_id
      t.integer :quiz_answer_id
      t.string :custom_answer

      t.timestamps
    end
  end
end
