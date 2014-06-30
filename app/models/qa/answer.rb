module Qa
	class Answer < Node
		
		def self.valid_parent_classes
			[Question]
		end
		
	end
end
