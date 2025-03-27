# frozen_string_literal: true

def create_user(email, admin = false)
  return false if User.exists?(email:)

  user = User.new(email:, password: 'Password1', password_confirmation: 'Password1')
  user.skip_confirmation!
  user.save!
  user.add_role :admin if admin
  user
end

create_user('admin@admin.pl')

5.times do
  food_provider = FactoryBot.create(:food_provider)
  FactoryBot.create_list(:offer, 4, food_provider:)
end

FactoryBot.create_list(:user, 2, :beneficiary)
