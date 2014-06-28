module Qa
	class Node < ActiveRecord::Base
		
		NODE = 'Qa::Node'
		QUESTION = 'Qa::Question'
		ANSWER = 'Qa::Answer'
		
		belongs_to :parent, class_name: NODE, inverse_of: :children
		has_many :children, class_name: NODE, foreign_key: :parent_id, inverse_of: :parent
		
		validates :summary, presence: true
		validates :parent, presence: true, :unless => lambda { QUESTION == type }
		
		validate :is_valid_parent_type?
		
		def is_valid_parent_type?
			if parent and not parent.type.in? self.class::VALID_PARENT_TYPES
				message = "is #{parent.type} but must be #{valid_parent_types_to_s}"
				errors.add(:parent, message)
			end
		end
		
		private
		
			def valid_parent_types_to_s
				self.class::VALID_PARENT_TYPES.map{ |e| e ? e : 'nothing' }.join(' or ')
			end
		
	end
end