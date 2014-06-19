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
		page.must_have_css '.response .body', text: @sub_response.body
	end
end

feature 'Creating a sub-response' do
	before do
		Node.all.each { |n| n.destroy }
		@question = Question.create summary: 'Blah?'
		@response = Response.create summary: 'Blah.', body: 'Blahty-blah.', parent: @question
		visit node_path(@response)
		
		page.must_have_css 'form'
	end
	
	scenario 'Submitting form does not create new response if invalid' do
		fill_in 'response[summary]', with: ''
		
		refute_difference('Response.count') { click_on 'Publish' }
	end
	
	scenario 'Submitting form creates new response if valid' do
		summary = 'This is a response summary.'
		fill_in 'response[summary]', with: summary
		body = 'And this is a response body'
		fill_in 'response[body]', with: body
		
		assert_difference('Response.count') { click_on 'Publish' }
		current_path.must_equal node_path(@response)
		page.must_have_css '.response .summary', text: summary
		page.must_have_css '.response .body', text: body
	end
end
