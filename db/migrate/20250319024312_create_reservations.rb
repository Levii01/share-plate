# frozen_string_literal: true

class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.references :offer, null: false, foreign_key: true
      t.references :beneficiary, null: false, foreign_key: true
      t.string :state
      t.datetime :picked_up

      t.timestamps
    end
  end
end
