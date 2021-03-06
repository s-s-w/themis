FactoryGirl.define do
  
  factory :node, :class => Qa::Node do
    summary 'Blah?'
    
    factory :title, :class => Qa::Title
    factory :question, :class => Qa::Question
    factory :answer, :class => Qa::Answer
    factory :subtype, :class => Qa::Subtype
    factory :support, :class => Qa::Support
    factory :oppose, :class => Qa::Oppose
  end
  
  trait :nil_is_parent do
  end
  
  trait :title_is_parent do
    after :build do |node|
      node.parent = build_stubbed :title
    end
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
  
  trait :subtyped_title_is_parent do
    after :build  do |node|
      node.parent = build :subtype, parent: build_stubbed(:title)
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