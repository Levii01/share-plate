# frozen_string_literal: true

FactoryBot.define do
  sequence(:user_email) { |n| "#{rand(10)}u#{n}@example.com" }

  factory :user do
    email { generate(:user_email) }
    password { 'Password1' }
    confirmed_at { Time.zone.now }
    fullname { Faker::Name.name }

    traits_for_enum :state, User.state_machine.states.keys

    trait :food_provider do
      state { :verifying }
      account_type { :food_provider }
      after(:build) { |user| user.food_provider ||= build(:food_provider) }
    end

    trait :beneficiary do
      state { :verifying }
      account_type { :beneficiary }
      after(:build) { |user| user.beneficiary ||= build(:beneficiary) }
    end
  end
end
