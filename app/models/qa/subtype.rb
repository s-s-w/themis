module Qa
	class Subtype < Node
		
		def valid_child_classes
			parent.valid_child_classes
		end
		
	end
end
