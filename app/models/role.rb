# frozen_string_literal: true

class Role < ApplicationRecord
  has_paper_trail

  has_and_belongs_to_many :users, join_table: :users_roles # rubocop:disable Rails/HasAndBelongsToMany
  # has_many :users, through: :users_roles  # TOTO: not supportef for RailsAdmin

  belongs_to :resource, polymorphic: true, optional: true

  validates :resource_type, inclusion: { in: Rolify.resource_types }, allow_nil: true

  scopify
end
