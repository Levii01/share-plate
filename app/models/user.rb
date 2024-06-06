# frozen_string_literal: true

class User < ApplicationRecord
  has_paper_trail
  rolify
  # Include default devise modules. Others available are: :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  state_machine :state, initial: :initialized do
    event :complete do
      transition [:initialized] => :completed
    end
  end

  def self.create_from_omniauth(auth) # rubocop:disable Metrics/AbcSize
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.fullname = auth.info.name
      user.avatar_url = auth.info.image
      user.password = Devise.friendly_token[0, 20]
      user.confirmed_at = Time.current
    end
  end
end
