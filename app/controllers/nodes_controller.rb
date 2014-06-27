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
			redirect_to( node_path(@new_node.parent || @new_node) )
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
		permitted_params = [:id, :summary, :body]
		
		if 'Response' == class_to_create.to_s
			permitted_params += [:parent_relation, :parent_id]
			params[:response][:parent_relation] = params[:relation]
		end
		
		params.require( class_to_create.to_s.downcase.to_sym ).permit( permitted_params )
	end
	
	def class_to_create
		params[:commit].include?('Ask') ? Question : Response
	end
	
end