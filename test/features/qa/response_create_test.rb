require 'test_helper'

module Qa
	feature 'Response create' do
		include ApplicationHelper
		
		before do
			@question = create :question
			@answer = create :answer, :question_is_parent
		end
		
		scenario 'Create new response fails if invalid' do
			[ @question, @answer ].each do |node|
				node.valid_child_classes.each do |valid_child_class|
					visit node_path(node)
					fill_in 'qa_node[summary]', with: ''
					refute_difference("#{valid_child_class.name}.count") { click_on submit_text_for(node, valid_child_class) }
				end
			end
		end
		
		scenario 'Creates new response succeeds if valid' do
			[ @question, @answer ].each do |node|
				node.valid_child_classes.each do |valid_child_class|
					visit node_path(node)
					summary = 'This is a response summary.'
					fill_in 'qa_node[summary]', with: summary
					body = 'And this is a response body'
					fill_in 'qa_node[body]', with: body
					
					assert_difference("#{valid_child_class.name}.count") { click_on submit_text_for(node, valid_child_class) }
					page.must_have_css "##{type_for valid_child_class} .summary", text: summary
					page.must_have_css "##{type_for valid_child_class} .body", text: body
				end
			end
		end
		
	end
end