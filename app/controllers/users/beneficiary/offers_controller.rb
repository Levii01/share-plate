# frozen_string_literal: true

module Users
  module Beneficiary
    class OffersController < ApplicationController
      def index
        @offers = Offer.available_today
      end
    end
  end
end
