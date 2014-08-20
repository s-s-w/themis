module Qa
	class Question < Node
		
		def self.valid_parent_classes
			[NilClass, Title]
		end
		
		def is_question?
			true
		end
		
		def supports_root?
			nil
		end
		
	end
end
