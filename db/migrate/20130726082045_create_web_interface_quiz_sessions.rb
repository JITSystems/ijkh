class CreateWebInterfaceQuizSessions < ActiveRecord::Migration
  def change
    create_table :quiz_sessions do |t|
      t.integer :user_id
      t.string :quiz_token
      t.integer :last_question_id

      t.timestamps
    end
  end
end
