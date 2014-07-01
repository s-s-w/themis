module Qa
	module ApplicationHelper
		
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
			color_type = type_for node
			color_type.in?( ['subtype', 'support', 'oppose'] ) ? color_type : nil
		end
		
		def wide_for node
			type_for(node).in?( ['question', 'answer'] )
		end
		
		def back_link_for node, text='Back', args={}
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