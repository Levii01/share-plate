# frozen_string_literal: true

class CreateFoodProviders < ActiveRecord::Migration[7.1]
  def change
    create_table :food_providers do |t|
      t.string :name
      t.text :description
      t.string :provider_type, null: false
      t.string :state, default: :initialized, null: false
      t.references :user, null: false, foreign_key: true
      t.string :address
      t.string :nip
      t.string :phone
      t.string :email
      t.text :opening_time
      t.boolean :active, default: false, null: false

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
