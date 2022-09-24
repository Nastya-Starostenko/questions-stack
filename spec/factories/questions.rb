# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    title { Faker::Lorem.word }
    body { Faker::Lorem.sentence }

    trait :invalid do
      title { nil }
    end

    trait :with_answers do
      after :create do |question|
        create_list(:answer, 2, question: question)
      end
    end
  end
end
