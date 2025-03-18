# frozen_string_literal: true

module Users
  module FoodProvider
    class OffersController < ApplicationController
      before_action :set_offer, only: %i[show edit update destroy]

      def index
        @offers = current_user.food_provider.offers
      end

      def show; end

      def new
        @offer = current_user.food_provider.offers.build
      end

      def edit; end

      def create
        @offer = current_user.food_provider.offers.build(offer_params)
        if @offer.save
          redirect_to edit_users_food_provider_offer_path(@offer), notice: 'Offer was successfully created.'
        else
          render :new
        end
      end

      def update
        if @offer.update(offer_params)
          redirect_to edit_users_food_provider_offer_path(@offer), notice: 'Offer was successfully updated.'
        else
          render :edit
        end
      end

      def destroy
        @offer.destroy
        redirect_to users_food_provider_offers_path, notice: 'Offer was successfully deleted.'
      end

      private

      def set_offer
        @offer = current_user.food_provider.offers.find(params[:id])
      end

      def offer_params
        params.require(:offer).permit(:name, :description, :available_from, :available_to, :status)
      end
    end
  end
end
