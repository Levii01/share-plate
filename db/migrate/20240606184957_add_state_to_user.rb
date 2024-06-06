# frozen_string_literal: true

class AddStateToUser < ActiveRecord::Migration[7.1]
  def change
    change_table :users, bulk: true do |t|
      t.string :state, default: 'created', null: false
      t.string :type
    end
  end
end
