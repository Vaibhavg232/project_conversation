FactoryBot.define do
  factory :status_change do
    old_status { "pending" }
    new_status { "in_progress" }
    association :project
  end
end 