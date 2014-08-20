module Qa
	class NodesController < ApplicationController
		include ApplicationHelper
		
		def trees
			@root_nodes = Node.root_nodes
		end
		
		def show
			@node = Node.find params[:id]
		end
		
		def new
			@new_node = Node.new
		end
		
		def create
			params[:qa_node][:type] = new_class.name
			@new_node = Node.create node_params
			
			if @new_node.valid?
				redirect_to selected_node_path(@new_node)
			else
				@node = @new_node.parent
				render path_to_form
			end
		end
		
		def archive
			@node = Node.find(params[:id])
			@node.update_columns archived_at: Time.zone.now
			redirect_to( @node.parent ? selected_node_path(@node.parent) : selected_node_path(@node) )
		end
		
		def restore
			@node = Node.find(params[:id])
			@node.update_columns archived_at: nil
			redirect_to selected_node_path(@node)
		end
		
		def destroy
			@node = Node.find(params[:id])
			@node.destroy
			redirect_to( @node.parent ? selected_node_path(@node.parent) : selected_node_path(@node) )
		end
		
		private
			
			def path_to_form
				case new_class.name.demodulize
				when 'Question' then 'new'
				else 'show'
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
			@node.valid? ? redirect_to(selected_node_path @node) : render('edit')
		end
		
	private
		
		def node_params
			params.require(:qa_node).permit(:id, :type, :parent_id, :summary, :body)
		end
		
		def new_class
			"Qa::#{new_short_type.classify}".constantize
		end
		
		def new_short_type
			params[:commit] = 'Subtype' if params[:commit].include? 'Sub-'
			params[:commit].downcase
		end
		
	end
end