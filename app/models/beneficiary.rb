# frozen_string_literal: true

class Beneficiary < ApplicationRecord
  has_paper_trail

  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true, length: { minimum: 30 }
  validates :phone, presence: true, format: { with: PHONE_REGEX }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  belongs_to :user
  accepts_nested_attributes_for :user

  state_machine :state, initial: :initialized
end
