require 'test_helper'

feature 'Creating a node' do
	scenario ''
end

#feature 'Creating a question' do
#	scenario 'Clicking link to create new question' do
#		visit questions_path
#		click_on 'Ask'
#		
#		page.must_have_css 'form'
#	end
	
#	scenario 'Submitting form does not create new question if invalid' do
#		visit new_question_path
#		fill_in 'question[summary]', with: ''
#		
#		refute_difference('Question.count') { click_on 'Ask' }
#	end
	
#	scenario 'Submitting form creates new question if valid' do
#		visit new_question_path
#		summary = 'This question summary has a question mark?'
#		fill_in 'question[summary]', with: summary
#		body = 'And here is a question body'
#		fill_in 'question[body]', with: body
#		
#		assert_difference('Question.count') { click_on 'Ask' }
#		current_path.must_equal question_path(Question.count)
#		page.must_have_css '#question .summary', text: summary
#		page.must_have_css '#question .body', text: body
#	end
#end
