# frozen_string_literal: true

FactoryBot.define do
  factory :offer do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence(word_count: 30) }
    available_from { Time.zone.now }
    available_to { 1.day.from_now }
    initial_quantity { 6 }
    remaining_quantity { 6 }

    # status {}
    food_provider
  end
end
