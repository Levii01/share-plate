# frozen_string_literal: true

class NipValidator < ActiveModel::EachValidator
  WEIGHTS = [6, 5, 7, 2, 3, 4, 5, 6, 7].freeze

  def validate_each(record, attribute, value)
    return if value.blank?
    return if NipValidator.valid?(value)

    message = options[:message] || I18n.t('errors.validators.nip')

    record.errors.add(attribute, message, value: NipValidator.sanitize(value))
  end

  def self.valid?(number)
    nip = NipValidator.sanitize(number)
    return false unless nip.length == 10

    nip_digits = nip.chars.map(&:to_i)

    (0..8).inject(0) { |s, i| s + (nip_digits[i] * WEIGHTS[i]) } % 11 == nip_digits.last
  end

  def self.sanitize(value)
    value.to_s.delete('^0-9')
  end
end
