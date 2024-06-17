# frozen_string_literal: true

class CreateBeneficiaries < ActiveRecord::Migration[7.1]
  def change
    create_table :beneficiaries do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.string :address
      t.text :description
      t.string :phone
      t.string :email
      t.string :state

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
