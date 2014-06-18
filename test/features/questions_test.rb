require 'test_helper'

feature 'Displaying questions list' do
	before do
		Question.all.each { |q| q.destroy }
	end
	
	scenario 'No questions' do
		visit questions_path
		assert page.has_css? '.question', text: 'no'
	end
	
	scenario 'One question' do
		question = Question.create summary: 'Blah?'
		visit questions_path
		
		page.must_have_css '.question .summary a', text: question.summary
	end
end
