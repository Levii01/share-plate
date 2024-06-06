# frozen_string_literal: true

class User < ApplicationRecord
  has_paper_trail
  rolify
  # Include default devise modules. Others available are: :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  def self.create_from_omniauth(auth)
    data = auth.info
    user = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = data.email
      user.fullname = data.name
      user.avatar_url = data.image
      user.password = Devise.friendly_token[0, 20]
      user.confirmed_at = Time.current
    end
  end
end
