FactoryGirl.define do
  
  factory :node, :class => Qa::Node do
    summary 'Blah?'
    
    factory :question, :class => Qa::Question
    factory :answer, :class => Qa::Answer
    factory :subtype, :class => Qa::Subtype
  end
  
  trait :question_is_parent do
    after :build do |node|
      node.parent = build_stubbed :question
    end
  end
  
  trait :answer_is_parent do
    after :build  do |node|
      node.parent = build_stubbed :answer
    end
  end
  
  trait :subtyped_question_is_parent do
    after :build  do |node|
      node.parent = build :subtype, parent: build_stubbed(:question)
    end
  end
  
  trait :subtyped_answer_is_parent do
    after :build do |node|
      node.parent = build :subtype, parent: build_stubbed(:answer)
    end
  end
  
end