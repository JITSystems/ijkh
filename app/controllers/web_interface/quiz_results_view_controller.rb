# encoding: utf-8 

class WebInterface::QuizResultsViewController < WebInterfaceController

  def show
  	# match 'quiz_results_view' => 'web_interface/quiz_results_view#show', :as => 'quiz_results_view', :via => :get
  	
  	@quiz_result = PollStatistics.fetch
  end

end