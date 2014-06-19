require 'test_helper'

feature 'Response create' do
	before do
		Node.all.each { |n| n.destroy }
		@question = Question.create summary: 'Blah?'
		@response = Response.create summary: 'Blah.', body: 'Blahty-blah.', parent: @question
	end
	
	scenario 'Forms exists' do
		visit node_path(@question)
		page.must_have_css 'form'
		
		visit node_path(@response)
		page.must_have_css 'form'
	end
	
	scenario 'Create new response fails if invalid' do
		[ @question, @response ].each do |node|
			visit node_path(node)
			fill_in 'response[summary]', with: ''
			
			refute_difference('Response.count') { click_on 'Publish' }
		end
	end
	
	scenario 'Creates new response succeeds if valid' do
		[ @question, @response ].each do |node|
			visit node_path(node)
			summary = 'This is a response summary.'
			fill_in 'response[summary]', with: summary
			body = 'And this is a response body'
			fill_in 'response[body]', with: body
			
			assert_difference('Response.count') { click_on 'Publish' }
			current_path.must_equal node_path(node)
			page.must_have_css '.response .summary', text: summary
			page.must_have_css '.response .body', text: body
		end
	end
end
