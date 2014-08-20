module Qa
	class Title < Node
		
		def self.valid_parent_classes
			[NilClass]
		end
		
		def is_title?
			true
		end
		
		def supports_root?
			nil
		end
		
	end
end
