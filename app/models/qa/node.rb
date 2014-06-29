module Qa
	class Node < ActiveRecord::Base
		
		belongs_to :parent, class_name: Node, inverse_of: :children
		has_many :children, class_name: Node, foreign_key: :parent_id, inverse_of: :parent
		
		validates :summary, presence: true
		validates :parent, presence: true, :unless => lambda { Question == self.class }
		validate :valid_ancestor_class?
		
	#private
		
		def valid_ancestor_class?
			ancestor = ancestor_excluding_subtype
			
			unless ancestor.class.in? self.class.valid_parent_classes
				message  = "is #{demodulized_name_for ancestor.class} "
				message += "but must be #{demodulized_names_for self.class.valid_parent_classes}"
				errors.add(:parent, message)
			end
		end
			
			def ancestor_excluding_subtype
				ancestor = parent
				
				while ancestor and (ancestor.class == Subtype)
					ancestor = ancestor.parent
				end
				
				ancestor
			end
			
			def demodulized_names_for klasses
				klasses.map{ |klass| demodulized_name_for klass }
			end
			
			def demodulized_name_for klass
				klass.name.demodulize
			end
			
			def valid_ancestor_classes_to_s
				self.class.valid_parent_classes.map{ |klass| klass.name.demodulize }.join(' or ')
			end
			
	end
end