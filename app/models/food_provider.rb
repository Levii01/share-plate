# frozen_string_literal: true

class FoodProvider < ApplicationRecord
  has_paper_trail

  PROVIDER_TYPES = %w[restaurant cafe bistro bakery confectionery deli other].freeze

  enum provider_type: PROVIDER_TYPES.index_by(&:to_sym)

  validates :name, presence: true
  validates :provider_type, presence: true
  validates :address, presence: true
  validates :nip, presence: true, nip: true, uniqueness: { case_sensitive: false }
  validates :phone, presence: true, format: { with: PHONE_REGEX }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :opening_time, presence: true, length: { minimum: 20 }
  validates :description, presence: true, length: { minimum: 30 }

  belongs_to :user
  has_many :offers, dependent: :destroy
  has_many :reservations, through: :offers

  state_machine :state, initial: :initialized

  def self.select_provider_type
    PROVIDER_TYPES.index_by { |k| I18n.t("activerecord.attributes.food_provider.provider_types.#{k}") }
  end
end
