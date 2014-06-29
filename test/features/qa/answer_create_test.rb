require 'test_helper'

module Qa
	feature 'Answer create' do
		include ApplicationHelper
		
		before do
			skip
			
			Node.all.each { |n| n.destroy }
			@question = Question.create summary: 'Blah?'
			@response = Response.create summary: 'Blah.', body: 'Blahty-blah.', parent: @question, parent_relation: 'Answer'
		end
		
		scenario 'Forms exists' do
			skip
			
			visit node_path(@question)
			page.must_have_css 'form'
			
			visit node_path(@response)
			page.must_have_css 'form'
		end
		
		scenario 'Create new response fails if invalid' do
			skip
			
			[ @question, @response ].each do |node|
				visit node_path(node)
				fill_in 'response[summary]', with: ''
				
				refute_difference('Response.count') { click_on child_relations_for(node).first }
			end
		end
		
		scenario 'Creates new response succeeds if valid' do
			skip
			
			[ @question, @response ].each do |node|
				visit node_path(node)
				summary = 'This is a response summary.'
				fill_in 'response[summary]', with: summary
				body = 'And this is a response body'
				fill_in 'response[body]', with: body
				
				assert_difference('Response.count') { click_on child_relations_for(node).first }
				current_path.must_equal node_path(node)
				page.must_have_css '.response .summary', text: summary
				page.must_have_css '.response .body', text: body
			end
		end
		
		scenario 'Supporting, Opposing, and Subtype responses display appropriately' do
			skip
			
			[ 'Support', 'Oppose', 'Subtype' ].each do |button|
				visit node_path(@response)
				click_on button
				
				page.must_have_css ".#{button.downcase}"
			end
		end
		
	end
end