# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    body { Faker::Lorem.sentence }
    association :question
  end

  trait :invalid do
    body { nil }
  end
end
