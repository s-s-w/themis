require 'test_helper'

feature 'Displaying questions list' do
	before do
		Node.all.each { |n| n.destroy }
	end
	
	scenario 'No questions' do
		visit questions_path
		assert page.has_css? '.question', text: 'no questions'
	end
	
	scenario 'One question' do
		question = Question.create summary: 'Blah?'
		visit questions_path
		page.must_have_css '.question .summary a', text: question.summary
	end
end

feature 'Creating a question' do
	before do
		Node.all.each { |n| n.destroy }
		visit questions_path
		click_on 'Ask'
		page.must_have_css 'form'
	end
	
	scenario 'Submitting form does not create new question if invalid' do
		fill_in 'question[summary]', with: ''
		refute_difference('Question.count') { click_on 'Publish' }
	end
	
	scenario 'Submitting form creates new question if valid' do
		summary = 'Here is a question summary'
		fill_in 'question[summary]', with: summary
		body = 'And here is a question body'
		fill_in 'question[body]', with: body
		assert_difference('Question.count') { click_on 'Publish' }
		current_path.must_equal node_path(Question.count)
		page.must_have_content 'Question'
		page.must_have_css '#question .summary', text: summary
		page.must_have_css '#question .body', text: body
		
		visit questions_path
		click_on 'Here'
		current_path.must_equal node_path(Question.count)
	end
end
