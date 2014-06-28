module Qa
	class Answer < Node
		
		def valid_parent_classes
			[Question, Answer]
		end
		
	end
end
