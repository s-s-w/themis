module Qa
	class Subtype < Node
		
		def self.valid_parent_classes
			Node.all_subclasses
		end
		
		def supports_root?
			parent.supports_root?
		end
		
		def is_argument?
			parent.is_argument?
		end
		
	end
end
