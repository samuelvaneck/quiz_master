# frozen_string_literal: true

FactoryBot.define do
  factory :awnser do
    content { Faker::Lorem.sentense }
    score { Faker::Number.number(digits: 4) }
  end
end