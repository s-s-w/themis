require 'test_helper'

feature 'Viewing a response' do
	before do
		Node.all.each { |n| n.destroy }
		@question = Question.create summary: 'Blah?'
		@response = Response.create summary: 'Blah.', body: 'Blahty-blah.', parent: @question
	end
	
	scenario 'Without responses' do
		visit node_path(@response)
		page.must_have_css '#response .summary', text: @response.summary
		page.must_have_css '#response .body', text: @response.body
		page.must_have_css '.response', text: 'no response'
	end
	
	scenario 'With response' do
		@sub_response = Response.create summary: 'Blah blah.', body: 'Blahty-blah-blah.', parent: @response
		visit node_path(@response)
		page.must_have_css '#response .summary', text: @response.summary
		page.must_have_css '#response .body', text: @response.body
		page.must_have_css '.response .summary', text: @sub_response.summary
		page.must_have_css '.response .body' #, text: @sub_response.body
	end
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
