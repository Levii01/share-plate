# frozen_string_literal: true

module Users
  module FoodProviders
    class ReservationsController < ApplicationController
      def index
        @q = food_provider.reservations.includes(:offer).ransack(params[:q])
        @pagy, @reservations = pagy(@q.result(distinct: true), limit: 5, items: 3)
      end

      def show
        @offer = reservation.offer
        @beneficiary = reservation.beneficiary
      end

      def update
        binding.pry
        if reservation.update(picked_up: Time.current, state: 'completed')
          redirect_to_reservation(notice: t('.success'))
        else
          redirect_to_reservation(alert: t('.failure'))
        end
      end

      def destroy
        if !reservation.cancelled? && reservation.cancel!
          reservation.offer.increment!(:remaining_quantity) # rubocop:disable Rails/SkipsModelValidations
          redirect_to_reservation(notice: t('.success'))
        else
          redirect_to_reservation(alert: t('.failure'))
        end
      end

      private

      def food_provider
        @food_provider ||= ::FoodProvider.find_by!(user: current_user)
      end

      def reservation
        @reservation ||= food_provider.reservations.find(params[:id])
      end

      def redirect_to_reservation(flash_message = {})
        redirect_to users_food_providers_reservation_path(reservation), flash_message
      end
    end
  end
end
