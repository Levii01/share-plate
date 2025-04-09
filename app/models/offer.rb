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

  scope :active, -> { where(available_from: Time.current.beginning_of_day..) }
  scope :expired, -> { where(available_from: ...Time.current.beginning_of_day) }

  def recalculate_remaining_quantity
    self.remaining_quantity = initial_quantity - reservation_conut
  end

  def reservation_conut
    reservations.without_state(:cancelled).count
  end

  def main_image_square
    main_image.variant(resize_to_fill: [160.0, 160.0]).processed
  end

  def main_image_rectangle
    main_image.variant(resize_to_fill: [516.0, 268.0]).processed
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[id hashid name available_from created_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[food_provider reservations]
  end

  def self.ransackable_scopes(_auth_object = nil)
    %w[active expired available]
  end

  def available?
    available_from >= Time.current.beginning_of_day
  end

  def status
    return 'Rozdane' if remaining_quantity.zero?
    return 'Dostępne' if available?

    'Zakończone'
  end
end
