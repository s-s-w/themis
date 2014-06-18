module ApplicationHelper
	
	def back_link_for node
		text = 'Back to '
		
		if node.class == Question
			text += 'questions'
			url = questions_path
		else
			url = node_path(node)
			
			if node.parent.class == Question
				text += 'question'
			else
				text += 'previous response'
			end
		end
		
		link_to text, url
	end
	
	def label_with_errors model, attribute
		content = attribute.to_s.titleize + errors_for(model, attribute)
		html(:label, content).html_safe
	end
	
	def errors_for model, attribute
		return '' if !model or model.errors.messages[attribute].blank?
		content = model[:attribute].to_s + dash + model.errors.messages[attribute].join(dash)
		html :span, content, :class => :errors
	end
	
	def html type, content=nil, args={}
		open_tag(type, args) + content.to_s + close_tag(type)
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
