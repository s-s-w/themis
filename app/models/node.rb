class Node < ActiveRecord::Base
	
	belongs_to :parent, class_name: 'Node', inverse_of: :children
	has_many :children, class_name: 'Node', foreign_key: :parent_id, inverse_of: :parent
	
	validates_presence_of :summary
	
end
