FactoryGirl.define do
  
  factory :node, :class => Qa::Node do
    summary 'Blah?'
    
    factory :question, :class => Qa::Question
    factory :answer, :class => Qa::Answer
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