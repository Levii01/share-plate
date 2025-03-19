# frozen_string_literal: true

FactoryBot.define do
  factory :reservation do
    offer
    beneficiary

    traits_for_enum :state, Reservation.state_machine.states.keys

    trait :picked_up do
      picked_up { Time.current }
    end
  end
end
