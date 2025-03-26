# frozen_string_literal: true

class AddHashidToOffer < ActiveRecord::Migration[7.1]
  def up
    add_column :offers, :hashid, :string
    Offer.find_each { |offer| offer.update_column(:hashid, offer.hashid) } # rubocop:disable Rails/SkipsModelValidations
  end

  def down
    remove_column :offers, :hashid
  end
end
