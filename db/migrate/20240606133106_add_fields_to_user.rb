# frozen_string_literal: true

class AddFieldsToUser < ActiveRecord::Migration[7.1]
  def change
    change_table :users, bulk: true do |t|
      t.string :fullname
      t.string :provider
      t.string :uid
      t.string :avatar_url
    end
  end
end
