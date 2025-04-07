FactoryBot.define do
  factory :tweet do
    association :user
    body { "This is a sample tweet" }
    created_at { Time.current }
    updated_at { Time.current }
  end
end
