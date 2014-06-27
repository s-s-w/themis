require 'test_helper'

class NodeText < ActiveSupport::TestCase
  include ApplicationHelper
  
  test 'valid' do
    [ :question ].each do |node_type|
      n = build node_type
      assert_equal true, n.valid?, n.errors.to_yaml
    end
  end
  
  test 'invalid without summary' do
    n = build :node
  	
    [nil, '', ' '].each do |bad_value|
  		n.summary = bad_value
			assert_equal false, n.valid?, n.errors.to_yaml
		end
	end
  
end
