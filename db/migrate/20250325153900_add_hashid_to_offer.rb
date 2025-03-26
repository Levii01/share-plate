# frozen_string_literal: true

class AddHashidToOffer < ActiveRecord::Migration[7.1]
  def change
    add_column :offers, :hashid, :string
  end
end
