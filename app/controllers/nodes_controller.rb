class NodesController < ApplicationController
	
	def show
		@node = Node.find id
		@new = Node.new parent: @node
	end
	
	def new
		@node = Node.new type: type
	end
	
	def create
		@node = Node.create(node_params)
		@node.valid? ? redirect_to(node_path( @node )) : render('new')
	end
	
private
	
	def id
		params[:id]
	end
	
	def type
		params[:type]
	end
	
	def node_params
		params.require(:node).permit( :id, :summary, :body )
	end
	
end