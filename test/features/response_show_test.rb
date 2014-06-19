require 'test_helper'

feature 'Response show' do
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
