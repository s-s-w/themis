require 'test_helper'

feature 'Node edit' do
	include ApplicationHelper
	
	before do
		Node.all.each { |n| n.destroy }
		@question = Question.create summary: 'Blah?'
		@response = Response.create summary: 'Blah.', parent: @question
		@subresponse = Response.create summary: 'Blah blah.', parent: @response
	end
	
	scenario 'Click edit link and fill out form' do
		visit node_path(@question)
		
		[ @question, @response ].each do |node|
			type = node.type.downcase
			
			[ '#' + type , '.response' ].each do |selector|
				visit node_path(node)
				
				within "#{selector} .header .actions" do
					click_on 'edit'
				end
				
				summary = 'Updated blah.'
				fill_in "#{ selector[1..-1] }[summary]", with: summary
				body = 'Updated blah blah.'
				fill_in "#{ selector[1..-1] }[body]", with: body
				
				refute_difference("#{node.class.to_s}.count") { click_on( parent_relations_for(node).first || 'Ask' ) }
				page.must_have_css "##{selector[1..-1]} .header .summary", text: summary
				page.must_have_css "##{selector[1..-1]} .body", text: body
			end
		end
	end
	
end
