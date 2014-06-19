class NodesController < ApplicationController
	
	def show
		@node = Node.find params[:id]
		@new_node = Response.new parent: @node
	end
	
	def new
		@new_node = Question.new
	end
	
	def create
		@new_node = class_to_create.create node_params
		if @new_node.valid?
			redirect_to(node_path(@new_node.parent || @new_node))
		else
			@node = @new_node.parent
			render path_to_form
		end
	end
	
	private
		
		def path_to_form
			return 'new' if Question == class_to_create
			return 'show' if Response == class_to_create
		end
		
public
	
	def edit
		@node = Node.find params[:id]
	end
	
	def update
		@node = Node.find params[:id]
		@node.update_attributes node_params
		@node.valid? ? redirect_to(node_path(@node)) : render('edit')
	end
	
private
	
	def node_params
		return params.require(:question).permit( :id, :summary, :body ) if 'Question' == class_to_create.to_s
		return params.require(:response).permit( :id, :summary, :body, :parent_id ) if 'Response' == class_to_create.to_s
	end
	
	def class_to_create
		return Question if params[:commit].include? 'Question'
		return Response if params[:commit].include? 'Response'
	end
	
end