FactoryBot.define do
  factory :comment do
    body { "Test comment" }
    association :project
    
    trait :with_parent do
      parent { association :comment }
    end
  end
end 