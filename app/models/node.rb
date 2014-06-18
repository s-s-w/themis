class Node < ActiveRecord::Base
	
	belongs_to :parent, polymorphic: true
	has_many :children, as: :parent, class_name: 'Node'
	
	validates_presence_of :summary
	
	def has_children?
		!children.blank?
	end
	
end
