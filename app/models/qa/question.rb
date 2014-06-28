module Qa
	class Question < Node
		
		def valid_parent_classes
			[NilClass, Question]
		end
		
	end
end
