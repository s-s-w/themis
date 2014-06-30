module Qa
	class Oppose < Node
		
		def self.valid_parent_classes
			[Answer, Support, Oppose]
		end
		
	end
end
