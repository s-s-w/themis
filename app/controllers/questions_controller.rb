class QuestionsController < ApplicationController

	def index
		@questions = Question.all
	end
	
	def create
		@node = Question.create question_params
		@node.valid? ? redirect_to(node_path( @node )) : render('nodes/new')
	end
	
private
	
	def question_params
		params.require(:question).permit( :id, :summary, :body )
	end
	
end