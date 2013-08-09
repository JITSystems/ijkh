# encoding: utf-8 

class WebInterface::QuizResultsViewController < WebInterfaceController

  def show
  	@quiz_result = PollStatistics.fetch
  end

end