FactoryBot.define do
  factory :project_event do
    association :project
    
    trait :with_comment do
      association :eventable, factory: :comment
    end
    
    trait :with_status_change do
      association :eventable, factory: :status_change
    end
  end
end 