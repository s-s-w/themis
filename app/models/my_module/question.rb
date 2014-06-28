module MyModule
	class Question < Node
		
		validate :is_valid_parent_type?
		
		def is_valid_parent_type?
			errors.add(:parent, "is #{parent.type} but must be Question if it exists") if parent and not QUESTION == parent.type
		end
		
	end
end
