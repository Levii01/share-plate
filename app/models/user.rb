# frozen_string_literal: true

class User < ApplicationRecord
  has_paper_trail
  rolify

  # Include default devise modules. Others available are: :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  enum account_type: %w[food_provider beneficiary].index_by(&:to_sym), _prefix: :account

  has_one :food_provider, dependent: :nullify

  state_machine :state, initial: :initialized do
    event :type_confirm do
      transition [:initialized] => :type_confirmed
    end

    event :verify do
      transition %i[type_confirmed] => :verifying
    end

    event :complete do
      transition %i[verifying type_confirmed initialized] => :completed
    end

    state :initialized do
      validates :account_type, absence: true
    end

    state all - :initialized do
      validates :account_type, presence: true
    end

    # state :type_confirmed do
    #   validates :account_type, presence: true
    # end
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
