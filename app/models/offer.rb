# frozen_string_literal: true

class Offer < ApplicationRecord
  has_paper_trail

  belongs_to :food_provider
  has_many :reservations, dependent: :destroy
  has_one_attached :main_image

  validates :name, presence: true
  validates :description, presence: true
  validates :initial_quantity, presence: true, numericality: { greater_than: 0 }
  validates :remaining_quantity, presence: true, numericality: { greater_than: -0 }

  before_update :recalculate_remaining_quantity, if: :initial_quantity_changed?

  scope :available_today, -> { where(available_from: Time.zone.today.all_day) }

  def recalculate_remaining_quantity
    self.remaining_quantity = initial_quantity - reservation_conut
  end

  def reservation_conut
    reservations.without_state(:cancelled).count
  end

  def main_image_square
    main_image.variant(resize_to_fill: [160.0, 160.0]).processed
  end
end
