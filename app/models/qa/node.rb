module Qa
	class Node < ActiveRecord::Base
		
		belongs_to :parent, class_name: Node, inverse_of: :children
		has_many :children, class_name: Node, foreign_key: :parent_id, inverse_of: :parent, dependent: :destroy
		
		validates :summary, presence: true
		validates :parent, presence: true, :unless => lambda { self.class.in? [Title, Question, Answer] }
		#validate :valid_ancestor_class?
		
		after_update :make_class_valid_child_of_parent
		
		def is_subtype?()		false; end
		def is_title?()			false; end
		def is_question?()	false; end
		def is_answer?()		false; end
		def is_argument?()	false; end
		
		scope :root_nodes, -> { where(parent: nil) }
		
		def tree_has_archived_nodes?
			all_nodes_in_tree.reject{ |node| node.archived_at.nil? }.count > 0
		end
		
		def all_nodes_in_tree
			[root] + root.descendants
		end
		
		def all_active_nodes_in_tree
			[root] + root.active_descendants
		end
		
		def is_title?()			false; end
		def is_question?()	false; end
		def is_answer?()		false; end
		def is_argument?()	false; end
		
		def is_root?
			parent.nil?
		end
		
		def root
			@root ||= is_root? ? self : parent.root
		end
		
		def altitude
			@altitude ||= max_depth - depth
		end
		
		def max_depth
			if is_root?
				@max_depth ||= all_active_nodes_in_tree.map{ |node| node.depth }.flatten.max
			else
				root.max_depth
			end
		end
		
		def depth
			@depth ||= parent.nil? ? 1 : parent.depth + 1
		end
		
		def descendants
			children + children.map{ |child| child.descendants }.flatten
		end
		
		def active_descendants
			active_children + active_children.map{ |child| child.active_descendants }.flatten
		end
		
		def active_children
			children.where( archived_at: nil )
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
		
		def has_active_children?
			active_children.any?
		end
		
		def has_children?
			children.any?
		end
		
		def ordered_children
			ordered_child_classes.map{ |klass| ordered_children_for klass.name }.flatten
		end
		
		def ordered_children_for node_class_name
			children.where(type: node_class_name).order(updated_at: :desc)
		end
		
		def ordered_child_classes
			[ Subtype, Title, Question, Answer, Support, Oppose ]
		end
		
		def valid_ordered_child_classes
			ordered_child_classes - invalid_child_classes
		end
		
		def invalid_child_classes
			ordered_child_classes - valid_child_classes
		end
		
		def valid_child_classes
			Node.all_subclasses.reject{ |nc| !nc.is_valid_child_class_of typed_node_for(self).class }
		end
			
			def self.is_valid_child_class_of klass
				valid_parent_classes.include? klass
			end
		
 	#private
		
		def make_class_valid_child_of_parent
			ancestor = typed_node_for parent
			
			unless ancestor.class.in? self.class.valid_parent_classes
				update_columns type: Subtype.name
			end
		end
		
		#def valid_ancestor_class?
		#	ancestor = typed_node_for parent
		#	
		#	unless ancestor.class.in? self.class.valid_parent_classes
		#		message  = "is #{demodulized_name_for ancestor.class} "
		#		message += "but must be #{demodulized_names_for self.class.valid_parent_classes}"
		#		errors.add(:parent, message)
		#	end
		#end
			
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