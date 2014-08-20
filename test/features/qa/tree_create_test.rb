require 'test_helper'

module Qa
	feature 'Tree create' do
		
		def before_for_trees
			visit trees_path
			click_on 'New'
		end
		
		scenario 'Submitting form does not create new tree if invalid' do
			before_for_trees
			
			fill_in 'qa_node[summary]', with: ''
			[ Question ].each do |klass|
				type = klass.name.split(':').last
				
				assert page.has_css?("##{type.downcase}_button")
				refute_difference("#{klass.name}.count") { click_on type }
			end
		end
		
		
		def before_for_questions
			visit questions_path
			click_on 'Ask'
			page.must_have_css 'form'
		end
		
		scenario 'Submitting form does not create new question if invalid' do
			before_for_questions
			
			fill_in 'qa_node[summary]', with: ''
			refute_difference('Qa::Question.count') { click_on 'Question' }
		end
		
		scenario 'Submitting form creates new question if valid' do
			before_for_questions
			
			summary = 'Here is a question summary'
			fill_in 'qa_node[summary]', with: summary
			body = 'And here is a question body'
			fill_in 'qa_node[body]', with: body
			assert_difference('Qa::Question.count') { click_on 'Question' }
			current_path.must_equal node_path(Question.last)
			page.must_have_content 'Question'
			page.must_have_css '#question .summary', text: summary
			page.must_have_css '#question .body', text: body
			
			visit questions_path
			click_on 'Here'
			current_path.must_equal node_path(Question.last)
		end
		
	end
end
