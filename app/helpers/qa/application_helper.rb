module Qa
	module ApplicationHelper
		
		def gradient_for node
			@oldest ||= node.root.created_at
			@newest ||= Time.zone.now
			current = node.updated_at || @oldest
			
			n = Math.log10(@newest - current + 1) / Math.log10(@newest - @oldest + 1) * 255
			hex = n.round.to_s(16)
			hex = '0' + hex if hex.length == 1
			
			'ffff' + hex
		end
		
		def selected_node_path node
			node_path(node) + (action_name == 'index' ? '' : '#selected')
		end
		
		def strike content
			content.gsub( '<p>', '<p><strike class="strike">' ).gsub( '</p>', '</strike></p>').html_safe
		end
		
		def archived_link_for node
			return unless node.tree_has_archived_nodes?
			
			if params[:deleted]
				link_to( "deletions&nbsp;are&nbsp;visible".html_safe, node_path(node) )
			else
				link_to( "deletions&nbsp;are&nbsp;hidden".html_safe, node_path(node) + '?deleted=show' )
			end
		end
		
		def edit_link_for node
			link_to 'edit', edit_node_path(node) + '#form', :class => 'edit'
		end
		
		def archive_or_restore_link_for node
			if node.archived_at
				html = link_to 'undelete', restore_node_path(node), :class => 'restore', method: :PATCH
				html += divider
				html += link_to 'delete permanently', "/nodes/#{node.id}", :class => 'delete_permanently', method: :DELETE, style: 'color:purple;' #,
					#data: { confirm: 'WARNING!\n\nTHIS CANNOT BE UNDONE!\n\nARE YOU ABSOLUTELY SURE?' }, style: 'color:purple;'
			else
				html = link_to( 'delete', archive_node_path(node), :class => 'archive', method: :PATCH )
			end
			
			html
		end
		
		def divider
			"<span style='color:lightgrey'> | </span>".html_safe
		end
		
		def submit_text_for this_node, new_child_class, is_edit
			if Subtype == new_child_class
				inherited_class_name = this_node.typed_node_for(this_node).class.name.demodulize
				is_known_class_name = inherited_class_name.in? ['Title', 'Question', 'Answer']
				(is_known_class_name and not is_edit) ? "Sub-#{inherited_class_name}" : 'Subtype'
			else
				new_child_class.name.demodulize
			end
		end
		
		def type_for node
			node_class = (node.class == Class) ? node : node.class
			node_class.name.demodulize.underscore
		end
		
		def color_type_for node
			if node.is_subtype?
				'subtype'
			elsif node.is_title?
				'title'
			elsif node.is_question?
				'question'
			elsif node.is_answer?
				'answer'
			elsif node.is_argument?
				type_for node
			else
				'new_node'
			end
		end
		
		def root_color_type_for node
			if node.is_subtype?
				'subtype'
			elsif node.is_argument?
				node.supports_root? ? 'support' : 'oppose'
			elsif node.is_title?
				'title'
			elsif node.is_question?
				'question'
			elsif node.is_answer?
				'answer'
			else
				'new_node'
			end
		end
		
		def parent_link_for node, text='parent', args={}
			parent = node.parent
			
			text = 'trees' if parent.nil?
			url = (parent.nil? ? trees_path : node_path(parent) + '#selected')
			args.merge!( {:class => 'parent' } )
			
			link_to text, url, args
		end
		
		def cancel_link_for node, text='Cancel', args={}
			parent = node.parent
			
			if node.new_record?
				url = js_void
				args.merge!( {onclick: "show_or_hide('#response_to_#{node.parent_id}')"} )
			elsif node.id.nil?
				url = (parent.nil? ? trees_path : node_path(parent) + '#selected')
			else
				url = node_path(node) + '#selected'
			end
			
			link_to text, url, args
		end
		
		def label_with_errors model, attribute, args={}
			content = attribute.to_s.titleize + errors_for(model, attribute)
			html :label, content, args
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
		
		def nbsp
			" &nbsp; ".html_safe
		end
		
		def br
			" <br /> ".html_safe
		end
		
		def js_void
			'javascript:void(0)'
		end
	end
end