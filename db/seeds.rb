# frozen_string_literal: true

5.times do
  food_provider = FactoryBot.create(:food_provider)
  FactoryBot.create_list(:offer, 4, food_provider:)
end

FactoryBot.create_list(:user, 2, :beneficiary)
