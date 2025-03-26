# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  PHONE_REGEX = /(?:(?:(?:\+|00)?48)|(?:\(\+?48\)))?(?:1[2-8]|2[2-69]|3[2-49]|4[1-8]|5[0-9]|6[0-35-9]|[7-8][1-9]|9[145])\d{7}/i # rubocop:disable Layout/LineLength

  include Hashid::Rails
  primary_abstract_class

  after_create -> { update_column(:hashid, hashid) if self.class.column_names.include?('hashid') } # rubocop:disable Rails/SkipsModelValidations
end
