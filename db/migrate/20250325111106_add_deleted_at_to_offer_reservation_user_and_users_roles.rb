# frozen_string_literal: true

class AddDeletedAtToOfferReservationUserAndUsersRoles < ActiveRecord::Migration[7.1]
  def change
    add_column :offers, :deleted_at, :datetime
    add_column :reservations, :deleted_at, :datetime
    add_column :users, :deleted_at, :datetime
    add_column :users_roles, :deleted_at, :datetime
  end
end
