# frozen_string_literal: true

class ChangeInitialQuantityInOffers < ActiveRecord::Migration[7.1]
  def change
    change_column :offers, :initial_quantity, :integer, default: 1, null: false # rubocop:disable Rails/ReversibleMigration
  end
end
