module Qa
	class Answer < Node
		
		def self.valid_parent_classes
			[NilClass, Title, Question]
		end
		
		def is_answer?
			true
		end
		
		def supports_root?
			nil
		end
		
	end
end
