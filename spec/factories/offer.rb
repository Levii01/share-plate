# frozen_string_literal: true

FactoryBot.define do
  factory :offer do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence(word_count: 30) }
    available_from { Time.zone.now }
    available_to { 1.day.from_now }
    initial_quantity { rand(2..7) }
    # status {}
    food_provider
  end
end
