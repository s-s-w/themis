module ApplicationHelper
	
	def parent_relations_for node
		if node.type == 'Question'
			[ nil ]
		elsif node.parent.type == 'Question'
			[ 'Answer', 'Subtype' ]
		else
			[ 'Support', 'Oppose', 'Subtype' ]
		end
	end
	
	def child_relations_for node
		if node.type == 'Question'
			[ 'Answer', 'Subtype' ]
		else
			[ 'Support', 'Oppose', 'Subtype' ]
		end
	end
	
	def back_link_for node, text=nil, args={}
		set_text = 'Back to '
		
		if node.class == Question
			set_text += 'questions'
			url = questions_path
		else
			url = node_path(node.parent)
			
			if node.parent.class == Question
				set_text += 'question'
			else
				set_text += 'previous response'
			end
		end
		
		text ||= set_text
		link_to text, url, args
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
		' &mdash; '
	end
	
end
