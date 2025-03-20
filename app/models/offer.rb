# frozen_string_literal: true

class Offer < ApplicationRecord
  has_paper_trail

  belongs_to :food_provider
  has_many :reservations, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :initial_quantity, presence: true, numericality: { greater_than: 0 }
  validates :remaining_quantity, presence: true, numericality: { greater_than: -0 }

  scope :available_today, -> { where(available_from: Time.zone.today.all_day) }

  def recalculate_remaining_quantity
    update!(remaining_quantity: initial_quantity - reservation_conut)
  end

  def reservation_conut
    reservations.without_state(:cancelled).count
  end
end
