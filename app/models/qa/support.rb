module Qa
	class Support < Node
		
		def self.valid_parent_classes
			[Answer, Support, Oppose]
		end
		
	end
end
