# frozen_string_literal: true

FactoryBot.define do
  factory :awnser do
    content { Faker::Lorem.sentence }
    score { Faker::Number.number(digits: 4) }

    trait :with_question do
      after(:build) do |awnser|
        awnser.question ||= FactoryBot.create(:question, position: Question.all.count)
      end
    end
  end
end
