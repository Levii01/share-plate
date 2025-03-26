# frozen_string_literal: true

module Users
  module Beneficiaries
    class OffersController < ApplicationController
      def index
        @q = Offer.active.ransack(params[:q])
        @pagy, @offers = pagy(@q.result(distinct: true), limit: 10)
      end

      def show
        @offer = Offer.includes(:food_provider).find(params[:id])
        @food_provider = @offer.food_provider
      end
    end
  end
end
