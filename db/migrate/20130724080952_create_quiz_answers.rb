class CreateQuizAnswers < ActiveRecord::Migration
  def change
    create_table :quiz_answers do |t|
      t.integer :quiz_question_id
      t.string :body

    end
  end
end
