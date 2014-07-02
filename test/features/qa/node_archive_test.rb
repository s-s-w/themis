require 'test_helper'

module Qa
	feature 'Node archive' do
		include ApplicationHelper
		
		before do
			@question = create :question
			@question_subtype = create :subtype, parent: @question
			@answer = create :answer, parent: @question_subtype
			@answer_subtype = create :subtype, parent: @answer
			@support = create :support, parent: @answer_subtype
			@support_subtype = create :subtype, parent: @support
			@oppose = create :oppose, parent: @support_subtype
			@oppose_subtype = create :subtype, parent: @oppose
		end
		
		scenario 'Click archive link' do
			visit node_path(@oppose_subtype)
			
			current_path.must_equal node_path(@oppose_subtype)
			assert @oppose_subtype.archived_at.nil?
			
			click_on 'delete'
			current_path.must_equal node_path(@oppose_subtype.parent)
			
			@oppose_subtype.reload
			refute_equal nil, @oppose_subtype.archived_at, @oppose_subtype.to_yaml
			
			refute page.has_css? ".#{type_for(@oppose_subtype)}"
		end
		
	end
end
