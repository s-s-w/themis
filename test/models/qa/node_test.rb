require 'test_helper'

module Qa
  class NodeTest < ActiveSupport::TestCase
    
    include ApplicationHelper
    
    test 'invalid without summary' do
      n = build :question
      
      [nil, '', ' '].each do |bad_value|
        n.summary = bad_value
        refute n.valid?, n.errors.to_yaml
      end
    end
    
    test 'title valid with nil as parent' do
      [ :nil_is_parent ].each do |trait|
        n = build :title, trait
        assert n.valid?, n.errors.to_yaml
      end
    end
    
    test 'title invalid with title, subtyped title, question, subtyped question, answer, or subtyped answer as parent' do
      [ :title_is_parent, :subtyped_title_is_parent, :question_is_parent, :subtyped_question_is_parent,
          :answer_is_parent, :subtyped_answer_is_parent ].each do |trait|
        n = build :title, trait
        refute n.valid?, n.errors.to_yaml
      end
    end
    
    test 'question valid with nil or title as parent' do
      [ :nil_is_parent, :title_is_parent ].each do |trait|
        n = build :question, trait
        assert n.valid?, n.errors.to_yaml
      end
    end
    
    test 'question invalid with question, subtyped question, answer, or subtyped answer as parent' do
      [ :question_is_parent, :subtyped_question_is_parent, :answer_is_parent, :subtyped_answer_is_parent ].each do |trait|
        n = build :question, trait
        refute n.valid?, n.errors.to_yaml
      end
    end
    
    test 'answer valid with nil, title, question or subtyped question as parent' do
      [ :nil_is_parent, :title_is_parent, :question_is_parent, :subtyped_question_is_parent ].each do |trait|
        n = build :answer, trait
        assert n.valid?, n.errors.to_yaml
      end
    end
    
    test 'answer invalid with answer, or subtyped answer as parent' do
      [ :answer_is_parent, :subtyped_answer_is_parent ].each do |trait|
        n = build :answer, trait
        refute n.valid?, n.errors.to_yaml
      end
    end
    
  end
end