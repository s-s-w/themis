module Qa
	class Node < ActiveRecord::Base
		
		belongs_to :parent, class_name: Node, inverse_of: :children
		has_many :children, class_name: Node, foreign_key: :parent_id, inverse_of: :parent
		
		validates :summary, presence: true
		validates :parent, presence: true, :unless => lambda { Question == self.class }
		validate :valid_ancestor_class?
		
		def root
			parent.nil? ? self : parent.root
		end
		
		def has_ancestor? node
			if self == node
				true
			elsif parent.nil?
				false
			else
				parent.has_ancestor? node
			end
		end
		
		def ordered_children
			ordered_child_classes.map{ |klass| ordered_children_for klass.name }.flatten
		end
		
		def ordered_children_for node_class_name
			children.where(type: node_class_name).order(updated_at: :desc)
		end
		
		def ordered_child_classes
			[ Subtype, Question, Answer, Support, Oppose ]
		end
		
		def valid_ordered_child_classes
			ordered_child_classes - invalid_child_classes
		end
		
		def invalid_child_classes
			ordered_child_classes - valid_child_classes
		end
		
		def valid_child_classes
			[ Subtype ] +
			Node.all_subclasses
				.reject{ |nc| nc == Subtype }
				.reject{ |nc| !nc.is_valid_child_class_of typed_node_for(self).class }
				#.reverse
		end
			
			def self.is_valid_child_class_of klass
				valid_parent_classes.include? klass
			end
		
 	#private
		
		def valid_ancestor_class?
			ancestor = typed_node_for parent
			
			unless ancestor.class.in? self.class.valid_parent_classes
				message  = "is #{demodulized_name_for ancestor.class} "
				message += "but must be #{demodulized_names_for self.class.valid_parent_classes}"
				errors.add(:parent, message)
			end
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
			
		def Node.all_subclasses
		  ObjectSpace.each_object(Class).select{ |klass| klass < Node }.uniq
		end
		
		def typed_node_for node
			while node and (node.class == Subtype)
				node = node.parent
			end
			
			node
		end
  
	end
end