FactoryBot.define do
  factory :project do
    sequence(:title) { |n| "Project #{n}" }
    description { "Test project description" }
    current_status { "pending" }
  end
end 