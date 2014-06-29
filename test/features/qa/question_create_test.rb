require 'test_helper'

module Qa
	feature 'Question create' do
		
		before do
			visit questions_path
			click_on 'Ask'
			page.must_have_css 'form'
		end
		
		scenario 'Submitting form does not create new question if invalid' do
			fill_in 'qa_node[summary]', with: ''
			refute_difference('Qa::Question.count') { click_on 'Ask' }
		end
		
		scenario 'Submitting form creates new question if valid' do
			summary = 'Here is a question summary'
			fill_in 'qa_node[summary]', with: summary
			body = 'And here is a question body'
			fill_in 'qa_node[body]', with: body
			assert_difference('Qa::Question.count') { click_on 'Ask' }
			#current_path.must_equal node_path(Question.last)
			#page.must_have_content 'Question'
			#page.must_have_css '#question .summary', text: summary
			#page.must_have_css '#question .body', text: body
			
			#visit questions_path
			#click_on 'Here'
			#current_path.must_equal node_path(Question.last)
		end
		
	end
end
