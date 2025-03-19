# frozen_string_literal: true

module Users
  module Beneficiary
    class OffersController < ApplicationController
      def index
        @q = Offer.available_today.ransack(params[:q])
        @pagy, @offers = pagy(@q.result(distinct: true), limit: 10)
      end

      def show
        @offer = Offer.includes(:food_provider).find(params[:id])
      end

      private

      # def set_offer
      #   @offer = Offer.find(params[:id])
      # end
    end
  end
end
