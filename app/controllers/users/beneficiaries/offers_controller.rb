# frozen_string_literal: true

module Users
  module Beneficiaries
    class OffersController < ApplicationController
      def index
        @q = Offer.ransack(params[:q])
        @pagy, @offers = pagy(
          @q.result(distinct: true).includes(:offer, :food_provider).order(created_at: :desc), limit: 10
        )
      end

      def show
        @offer = Offer.includes(:food_provider).find(params[:id])
        @food_provider = @offer.food_provider
      end
    end
  end
end
