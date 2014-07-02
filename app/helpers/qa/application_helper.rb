module Qa
	module ApplicationHelper
		
		def strike content
			content.gsub( '<p>', '<p><span class="strike">' ).gsub( '</p>', '</span></p>').html_safe
		end
		
		def archived_link_for node
			return unless node.tree_has_archived_nodes?
			
			if params[:archived]
				link_to( 'archived', node_path(node) )
			else
				link_to( 'archived', node_path(node) + '?archived=show' )
			end
		end
		
		def edit_link_for node
			link_to 'edit', edit_node_path(node), :class => 'edit'
		end
		
		def archive_or_restore_link_for node
			if node.archived_at
				link_to 'restore', restore_node_path(node), :class => 'restore', method: :PATCH
			else
				link_to 'archive', archive_node_path(node), :class => 'archive', method: :PATCH
			end
		end
		
		def submit_text_for new_child_class
			if Question == new_child_class
				'Ask Question'
			else
				new_child_class.name.demodulize
			end
		end
		
		def type_for node
			node_class = (node.class == Class) ? node : node.class
			node_class.name.demodulize.underscore
		end
		
		def color_type_for node
			if node.is_question?
				'question'
			elsif node.is_answer?
				'answer'
			elsif node.is_argument?
				type_for node
			else
				nil
			end
		end
		
		def root_color_type_for node
			if node.is_argument?
				node.supports_root? ? 'support' : 'oppose'
			elsif node.is_question?
				'question'
			elsif node.is_answer?
				'answer'
			else
				nil
			end
		end
		
		def wide_for node
			type_for(node).in?( ['question', 'answer'] )
		end
		
		def back_link_for node, text='back', args={}
			parent = node.parent
			link_to text, (parent.nil? ? questions_path : node_path(parent)), args
		end
		
		def label_with_errors model, attribute
			content = attribute.to_s.titleize + errors_for(model, attribute)
			html :label, content
		end
		
		def errors_for model, attribute
			return '' if !model or model.errors.messages[attribute].blank?
			content = model[:attribute].to_s + dash + model.errors.messages[attribute].join(dash)
			html :span, content, :class => :errors
		end
		
		def html type, content=nil, args={}
			( open_tag(type, args) + content.to_s + close_tag(type) ).html_safe
		end
		
		def open_tag type, args={}
			'<' + ( [ type.to_s ] + args.map{|k, v| "#{k}='#{v}'"} ).join(' ') + '>'
		end
		
		def close_tag type
			'</' + type.to_s + '>'
		end
		
		def dash
			" &mdash; ".html_safe
		end
		
	end
end