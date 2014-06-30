module Qa
	class NodesController < ApplicationController
		include ApplicationHelper
		
		def show
			@node = Node.find params[:id]
			@new_node = Node.new parent: @node
		end
		
		def new
			@new_node = Node.new
		end
		
		def create
			params[:qa_node][:type] = new_class.name
			@new_node = Node.create node_params
			
			if @new_node.valid?
				redirect_to( node_path(@new_node.parent || @new_node) )
			else
				@node = @new_node.parent
				render path_to_form
			end
		end
		
		private
			
			def path_to_form
				case new_class.name.demodulize
				when 'Question' then 'new'
				when 'Answer', 'Subtype' then 'show'
				end
			end
			
	public
		
		def edit
			@node = Node.find params[:id]
		end
		
		def update
			@node = Node.find params[:id]
			
			params[:qa_node] = params["qa_#{type_for(@node)}"]
			params[:qa_node][:type] = new_class.name
			
			@node.update_attributes node_params
			@node.valid? ? redirect_to(node_path(@node)) : render('edit')
		end
		
	private
		
		def node_params
			params.require(:qa_node).permit(:id, :type, :parent_id, :summary, :body)
		end
		
		def new_class
			"Qa::#{new_short_type.classify}".constantize
		end
		
		def new_short_type
			(params[:commit] == 'Ask Question') ? 'question' : params[:commit].downcase
		end
		
	end
end