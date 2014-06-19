require 'test_helper'

feature 'Questions index' do
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
