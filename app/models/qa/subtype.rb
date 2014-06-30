module Qa
	class Subtype < Node
		
		def self.valid_parent_classes
			Node.all_subclasses
		end
		
		def valid_child_classes
			parent.valid_child_classes
		end
		
	end
end
