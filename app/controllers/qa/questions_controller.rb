module Qa
	class QuestionsController < ApplicationController
	
		def index
			@questions = Question.all.order( updated_at: :desc )
		end
		
	end
end
