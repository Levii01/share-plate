# frozen_string_literal: true

class Offer < ApplicationRecord
  belongs_to :food_provider

  validates :name, presence: true
  validates :description, presence: true
  validates :initial_quantity, presence: true, numericality: { greater_than: 0 }

  scope :available_today, -> { where(available_from: Time.zone.today.all_day) }
end
