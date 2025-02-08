FactoryBot.define do
  factory :post do
    body { Faker::Lorem.sentence }
    draft { false }

    trait :draft do
      draft { true }
    end

    trait :published do
      published_at { 1.day.ago }
    end
  end
end
