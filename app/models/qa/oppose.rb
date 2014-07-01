module Qa
	class Oppose < Node
		
		def self.valid_parent_classes
			[Answer, Support, Oppose]
		end
		
		def supports_root?
			parent.is_argument? ? !parent.supports_root? : false
		end
		
		def is_question?
			false
		end
		
		def is_answer?
			false
		end
		
		def is_argument?
			true
		end
		
	end
end
