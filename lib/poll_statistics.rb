class PollStatistics
	def self.fetch
		statistics = []
		statistics_el = {}
		poll_questions = WebInterface::QuizQuestion.all
		poll_questions.each do |pq|
			answers = []
			statistics_el[:quiz_question] = pq.as_json
			poll_answers = pq.quiz_answers
			poll_answers.each do |pa|
				answer = pa.as_json
				answers_total = pa.quiz_results.count
				answer[:quiz_result] = {count: answers_total}
				custom_answers = pa.quiz_results.select("custom_answer").where("custom_answer != ''").as_json
				if custom_answers.first
					answer.merge!(custom_answers: custom_answers)
				end
				answers << answer
			end
			statistics_el[:quiz_question][:quiz_answer] = answers
			statistics << statistics_el
			statistics_el = {}
			answers = []
		end
		return statistics
	end
end