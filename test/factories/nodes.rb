FactoryGirl.define do
  
  factory :node do
    summary 'Blah?'
    
    factory :question, :class => 'Question', traits: [ :subtype ]
    
    #factory :assertion, :class => 'Assertion', traits: [ :subtype ] #do
    #  factory :supporting_assertion
    #  factory :opposing_assertion
    #end
    
    trait :subtype do
      after(:build) do |node|
        node.parent = node.class.new
      end
    end
  end
  
end