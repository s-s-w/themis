module Qa
	class Question < Node
		
		def self.valid_parent_classes
			[NilClass]
		end
		
		def is_question?
			true
		end
		
		def is_answer?
			false
		end
		
		def is_argument?
			false
		end
		
		def supports_root?
			nil
		end
		
	end
end
