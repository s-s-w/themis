require 'test_helper'

module Qa
	feature 'Support and Oppose create' do
		include ApplicationHelper
		
		before do
			@answer = create :answer, :question_is_parent
		end
		
		scenario 'Form exists with correct options' do
			visit node_path(@answer)
			page.must_have_css 'form'
			
			[ 'sub_answer', 'support', 'oppose', 'cancel' ].each do |action|
				page.must_have_css "##{action}_button"
			end
		end
		
		scenario 'Create new response fails if invalid' do
			nodes = [ @answer ]
			[ :subtype, :support, :oppose ].each do |node_type|
				nodes << create(node_type, parent: @answer)
			end
			
			nodes.each do |node|
				node.valid_child_classes.each do |valid_child_class|
					visit node_path(node)
					fill_in 'qa_node[summary]', with: ''
					refute_difference("#{valid_child_class.name}.count") { click_on submit_text_for(node, valid_child_class) }
				end
			end
		end
		
	end
end
