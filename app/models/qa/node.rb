module QA
	class Node < ActiveRecord::Base
		
		NODE = 'QA::Node'
		QUESTION = 'QA::Question'
		
		belongs_to :parent, class_name: NODE, inverse_of: :children
		has_many :children, class_name: NODE, foreign_key: :parent_id, inverse_of: :parent
		
		validates :summary, presence: true
		validates :parent, presence: true, :unless => lambda { QUESTION == type }
		
		def is_question?
			QUESTION == type
		end
		
	end
end