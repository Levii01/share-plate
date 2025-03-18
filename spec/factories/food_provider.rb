# frozen_string_literal: true

FactoryBot.define do
  sequence(:food_provider_email) { |n| "#{rand(10)}#{rand(10)}f#{n}@example.com" }

  factory :food_provider do
    email { generate(:food_provider_email) }
    name { Faker::Name.name }
    provider_type { FoodProvider::PROVIDER_TYPES.sample }
    address { Faker::Address.full_address }
    nip { Faker::Company.polish_taxpayer_identification_number }
    # phone { Faker::PhoneNumber.subscriber_number(length: 9) }
    phone { '504626402' }
    opening_time { '8-16 pn-nd \n' * 10 }
    description { Faker::Lorem.sentence(word_count: 30) }

    traits_for_enum :state, FoodProvider.state_machine.states.keys

    after(:build) do |food_provider|
      food_provider.user ||= build(:user, :completed, email: food_provider.email,
                                                      fullname: food_provider.name,
                                                      account_type: :food_provider)
    end
  end
end
