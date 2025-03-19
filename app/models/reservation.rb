# frozen_string_literal: true

class Reservation < ApplicationRecord
  has_paper_trail

  belongs_to :offer
  belongs_to :beneficiary

  # validates :status, presence: true, inclusion: { in: %w[pending confirmed cancelled completed] }
  # validates :picked_up, presence: true, if: :completed?

  state_machine :state, initial: :pending do
    event :cancel do
      transition %i[pending completed] => :cancelled
    end

    event :complete do
      transition %i[pending] => :completed
    end

    event :process do
      transition %i[cancelled completed] => :pending
    end

    state :completed do
      validates :picked_up, presence: true
    end
  end
end
