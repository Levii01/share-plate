# frozen_string_literal: true

FactoryBot.define do
  sequence(:beneficiary_email) { |n| "#{rand(10)}b#{n}@example.com" }

  factory :beneficiary do
    email { generate(:beneficiary_email) }
    name { Faker::Name.name }
    address { Faker::Address.full_address }
    phone { Faker::PhoneNumber.subscriber_number(length: 9) }
    description { Faker::Lorem.sentence(word_count: 30) }

    traits_for_enum :state, Beneficiary.state_machine.states.keys

    after(:build) do |beneficiary|
      beneficiary.user ||= build(:user, :completed, email: beneficiary.email,
                                                    fullname: beneficiary.name,
                                                    account_type: :beneficiary)
    end
  end
end
