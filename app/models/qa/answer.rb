module Qa
	class Answer < Node
		
		def self.valid_parent_classes
			[Question]
		end
		
		def valid_child_classes
			[Subtype]
		end
		
	end
end
