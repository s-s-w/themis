require 'test_helper'

module Qa
  class NodeTest < ActiveSupport::TestCase
    
    include ApplicationHelper
    
    test 'invalid without summary' do
      n = build :question
      
      [nil, '', ' '].each do |bad_value|
        n.summary = bad_value
        assert_equal false, n.valid?, n.errors.to_yaml
      end
    end
    
    test 'question invalid with question, subtyped question, answer, or subtyped answer as parent' do
      [ :question_is_parent, :subtyped_question_is_parent, :answer_is_parent, :subtyped_answer_is_parent ].each do |trait|
        n = build :question, trait
        assert_equal false, n.valid?, n.errors.to_yaml
      end
    end
    
    test 'question valid with nil as parent' do
      n = build :question
      assert_equal true, n.valid?, n.errors.to_yaml
    end
    
    test 'answer invalid with nil, answer, or subtyped answer as parent' do
      [ nil, :answer_is_parent, :subtyped_answer_is_parent ].each do |trait|
        n = build :answer, trait
        assert_equal false, n.valid?, n.errors.to_yaml
      end
    end
    
    test 'answer valid with question or subtyped question as parent' do
      [ :question_is_parent, :subtyped_question_is_parent ].each do |trait|
        n = build :answer, trait
        assert_equal true, n.valid?, n.errors.to_yaml
      end
    end
    
  end
end