module Qa
	class Subtype < Node
		
		def self.valid_parent_classes
			Node.all_subclasses
		end
		
		def is_subtype?
			true
		end
		
		def is_argument?
			parent.is_argument?
		end
		
		def supports_root?
			parent.supports_root?
		end
		
		def is_title?
			parent.is_title?
		end
		
		def is_question?
			parent.is_question?
		end
		
		def is_answer?
			parent.is_answer?
		end
		
	end
end
