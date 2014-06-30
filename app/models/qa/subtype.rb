module Qa
	class Subtype < Node
		
		def self.valid_parent_classes
			[Question, Answer]
		end
		
		def valid_child_classes
			parent.valid_child_classes
		end
		
	end
end
