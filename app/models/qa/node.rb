module Qa
	class Node < ActiveRecord::Base
		
		belongs_to :parent, class_name: Node, inverse_of: :children
		has_many :children, class_name: Node, foreign_key: :parent_id, inverse_of: :parent
		
		validates :summary, presence: true
		validates :parent, presence: true, :unless => lambda { Question == self.class }
		validate :valid_parent_class?
		
		def valid_parent_class?
			if parent and not parent.class.in? valid_parent_classes
				message = "is #{parent.class} but must be #{valid_parent_classes.join(' or ')}"
				errors.add(:parent, message)
			end
		end
		
	end
end