class AddHasCustomFiledToQuizQuestions < ActiveRecord::Migration
  def change
  	 add_column :quiz_questions, :has_custom, :boolean
  end
end
