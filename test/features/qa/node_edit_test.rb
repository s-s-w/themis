require 'test_helper'

module Qa
	feature 'Node edit' do
		include ApplicationHelper
		
		before do
			@question = create :question
			@question_subtype = create :subtype, parent: @question
			@answer = create :answer, parent: @question
			@answer_subtype = create :subtype, parent: @answer
		end
		
		scenario 'Click edit link and fill out form' do
			[ @question, @question_subtype, @answer, @answer_subtype ].each do |node|
				visit node_path(node)
				
				edit_link = all( 'a .edit' ).first
				
				within "##{type_for(node)}" do
					click_on 'edit'
				end
				
				summary = 'Updated blah.'
				fill_in "qa_#{type_for(node)}[summary]", with: summary
				body = 'Updated blah blah.'
				fill_in "qa_#{type_for(node)}[body]", with: body
				
				refute_difference("#{node.class.to_s}.count") { click_on submit_text_for(node.class) }
				
				page.must_have_css "##{type_for(node)} .header .summary", text: summary
				page.must_have_css "##{type_for(node)} .body", text: body
			end
		end
		
	end
end
