FactoryGirl.define do
  
  factory :node, :class => MyModule::Node do
    summary 'Blah?'
    
    factory :question, :class => MyModule::Question
    factory :answer, :class => MyModule::Answer
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