require 'test_helper'

module Qa
  class NodeTest < ActiveSupport::TestCase
    
    include ApplicationHelper
    
    test 'invalid without summary' do
      n = build :node
      
      [nil, '', ' '].each do |bad_value|
        n.summary = bad_value
        assert_equal false, n.valid?, n.errors.to_yaml
      end
    end
    
    test 'question invalid with answer as parent' do
      n = build :question, :answer_is_parent
      assert_equal false, n.valid?, n.errors.to_yaml
    end
    
    test 'question valid with nil or question as parent' do
      [ nil, :question_is_parent ].each do |trait|
        n = build :question, trait
        assert_equal true, n.valid?, n.errors.to_yaml
      end
    end
    
    test 'answer invalid without parent' do
      n = build :answer
      assert_equal false, n.valid?, n.errors.to_yaml
    end
    
    test 'answer valid with question or answer as parent' do
      [ :question_is_parent, :answer_is_parent ].each do |trait|
        n = build :answer, trait
        assert_equal true, n.valid?, n.errors.to_yaml
      end
    end
    
  end
end