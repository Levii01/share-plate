# frozen_string_literal: true

class AddRemainingQuantityToOffers < ActiveRecord::Migration[7.1]
  def change
    add_column :offers, :remaining_quantity, :integer, default: 0, null: false
  end
end
