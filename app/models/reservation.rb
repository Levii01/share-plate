# frozen_string_literal: true

class Reservation < ApplicationRecord
  has_paper_trail

  belongs_to :offer
  belongs_to :beneficiary
  has_one :food_provider, through: :offer

  validates :picked_up, presence: true, if: :completed?

  state_machine :state, initial: :active do
    event :cancel do
      transition %i[active completed] => :cancelled
    end

    event :complete do
      transition %i[active] => :completed
    end

    # event :activate do
    #   transition %i[cancelled] => :active
    # end

    state :completed do
      validates :picked_up, presence: true
    end
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[hashid picked_up state updated_at created_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[beneficiary offer]
  end
end
