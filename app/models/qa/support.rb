module Qa
	class Support < Node
		
		def self.valid_parent_classes
			[Answer, Support, Oppose]
		end
		
		def supports_root?
			parent.is_argument? ? parent.supports_root? : true
		end
		
		def is_argument?
			true
		end
		
	end
end
