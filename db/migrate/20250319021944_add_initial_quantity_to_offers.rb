# frozen_string_literal: true

class AddInitialQuantityToOffers < ActiveRecord::Migration[7.1]
  def change
    add_column :offers, :initial_quantity, :integer
  end
end
