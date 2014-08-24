require 'test_helper'

module Qa
	feature 'Trees index' do
		
		scenario 'No root nodes' do
			visit trees_path
			assert page.has_css? '.root_node', text: 'None'
		end
		
		scenario 'Has root nodes' do
			[Title, Question, Answer].each do |klass|
				node = klass.create summary: 'Blah?'
				visit trees_path
				
				css_class = klass.name.split(':').last.downcase
				page.must_have_css "li.#{css_class} .branch_header a" #, text: question.summary
			end
		end
		
	end
end