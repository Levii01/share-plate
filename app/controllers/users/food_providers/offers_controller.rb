# frozen_string_literal: true

module Users
  module FoodProviders
    class OffersController < ApplicationController
      before_action :set_offer, only: %i[show edit update destroy]
      before_action :require_food_provider

      # TODO: redirect if not food provider

      def index
        @q = current_user.food_provider.offers.available_from_today.ransack(params[:q])
        @pagy, @offers = pagy(@q.result(distinct: true), limit: 10)
      end

      def show; end

      def new
        @offer = current_user.food_provider.offers.build
      end

      def edit; end

      def create
        @offer = current_user.food_provider.offers.build(offer_create_params)
        if @offer.save
          redirect_to users_food_providers_offers_path, notice: 'Offer was successfully created.'
        else
          render :new
        end
      end

      def update
        @offer.lock!
        if @offer.update(offer_params)
          redirect_to edit_users_food_providers_offer_path(@offer), notice: 'Offer was successfully updated.'
        else
          render :edit
        end
      end

      def destroy
        @offer.destroy
        redirect_to users_food_providers_offers_path, notice: 'Offer was successfully deleted.'
      end

      private

      def set_offer
        @offer = current_user.food_provider.offers.find(params[:id])
      end

      def offer_create_params
        offer_params.merge(remaining_quantity: offer_params[:initial_quantity])
      end

      def offer_params
        params.require(:offer).permit(:name, :description, :available_from, :available_to, :status, :initial_quantity,
                                      :main_image)
      end
    end
  end
end
