# frozen_string_literal: true

class Reservation < ApplicationRecord
  has_paper_trail

  belongs_to :offer
  belongs_to :beneficiary

  # validates :status, presence: true, inclusion: { in: %w[active confirmed cancelled completed] }
  # validates :picked_up, presence: true, if: :completed?

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
    %w[beneficiary_id created_at id id_value offer_id picked_up state updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[beneficiary offer]
  end
end
# 