# frozen_string_literal: true

class CreateOffers < ActiveRecord::Migration[7.1]
  def change
    create_table :offers do |t|
      t.references :food_provider, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.datetime :available_from
      t.datetime :available_to
      t.string :status

      t.timestamps
    end
  end
end
