module Qa
	class Answer < Node
		
		def self.valid_parent_classes
			[Question]
		end
		
		def is_argument?
			false
		end
		
		def supports_root?
			nil
		end
		
	end
end
