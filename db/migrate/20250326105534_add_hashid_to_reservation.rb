# frozen_string_literal: true

class AddHashidToReservation < ActiveRecord::Migration[7.1]
  def up
    add_column :reservations, :hashid, :string
    Reservation.find_each { |reservation| reservation.update_column(:hashid, reservation.hashid) } # rubocop:disable Rails/SkipsModelValidations
  end

  def down
    remove_column :reservations, :hashid
  end
end
