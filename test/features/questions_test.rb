require 'test_helper'

feature 'Displaying questions list' do
	before do
		Question.all.each { |q| q.destroy }
	end
	
	scenario 'No questions' do
		visit questions_path
		assert page.has_css? '.question', text: 'no'
	end
end
