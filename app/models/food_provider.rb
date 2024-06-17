# frozen_string_literal: true

class FoodProvider < ApplicationRecord
  has_paper_trail

  PROVIDER_TYPES = %i[restaurant cafe bistro bakery confectionery deli other].freeze
  PHONE_REGEX = /(?:(?:(?:\+|00)?48)|(?:\(\+?48\)))?(?:1[2-8]|2[2-69]|3[2-49]|4[1-8]|5[0-9]|6[0-35-9]|[7-8][1-9]|9[145])\d{7}/i.freeze

  enum provider_type: PROVIDER_TYPES.index_by(&:to_sym)

  validates :name, presence: true
  validates :provider_type, presence: true
  validates :address, presence: true
  validates :nip, presence: true, nip: true, uniqueness: { case_sensitive: false }
  validates :phone, presence: true, format: { with: PHONE_REGEX }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :opening_time, presence: true, length: { minimum: 30 }
  validates :description, presence: true, length: { minimum: 20 }

  belongs_to :user

  state_machine :state, initial: :initialized

  def self.select_provider_type
    PROVIDER_TYPES.index_by { |k| I18n.t("activerecord.attributes.food_provider.provider_types.#{k}") }
  end
end
