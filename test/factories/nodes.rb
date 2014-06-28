FactoryGirl.define do
  
  factory :node, :class => QA::Node do
    summary 'Blah?'
    
    factory :question, :class => QA::Question
    factory :answer, :class => QA::Answer
  end
  
  trait :answer_is_parent do
    after(:build) do |node|
      node.parent = build_stubbed(:answer)
    end
  end
  
  trait :question_is_parent do
    after(:build) do |node|
      node.parent = build_stubbed(:question)
    end
  end
  
end