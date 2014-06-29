module Qa
	class Question < Node
		
		def self.valid_parent_classes
			[NilClass]
		end
		
		def valid_child_classes
			[Subtype, Answer]
		end
		
	end
end
