class NodesController < ApplicationController
	
	def show
		@node = Node.find params[:id]
		@new_node = Node.new type: 'Response', parent: @node
	end
	
	def new 	#only used by questions
		@new_node = Node.new type: params[:type]
	end
	
	def create
		@new_node = class_to_create.create node_params
		if @new_node.valid?
			redirect_to(node_path(@new_node))
		else
			render('new')
		end
	end
	
	private
		
		def render_failure
			case class_to_create
			when Question
				render '/questions/new'
			when Response
				render 'new'
			end
		end
		
		def class_to_create
			if params[:commit].include? 'Question'
				Question
			elsif params[:commit].include? 'Response'
				Response
			end
		end
		
	
private
	
	def node_params
		case class_to_create.to_s
		when 'Question'
			params.require(:question).permit( :id, :summary, :body )
		when 'Response'
			params.require(:response).permit( :id, :summary, :body, :parent_id )
		end
	end
	
end