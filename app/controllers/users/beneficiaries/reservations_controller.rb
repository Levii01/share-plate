# frozen_string_literal: true

module Users
  module Beneficiaries
    class ReservationsController < ApplicationController
      before_action :set_offer, only: [:create]
      before_action :set_reservation, only: %i[show update destroy]

      def index
        @beneficiary = current_user.beneficiary
        @q = @beneficiary.reservations.includes(:offer).ransack(params[:q])
        @pagy, @reservations = pagy(@q.result(distinct: true), limit: 5, items: 3)
      end

      def show
        @offer = @reservation.offer
        @food_provider = @offer.food_provider
      end

      def create
        @reservation = current_user.beneficiary.reservations.new(offer: @offer)

        ActiveRecord::Base.transaction do
          @offer.lock!

          return redirect_with_error(t('.no_packages')) if @offer.remaining_quantity.zero?

          create_reservation
        rescue StandardError => e
          redirect_with_error(t('.error', error_message: e.message))
        end
      end

      def destroy
        if !@reservation.cancelled? && @reservation.cancel!
          @reservation.offer.increment!(:remaining_quantity) # rubocop:disable Rails/SkipsModelValidations
          redirect_to users_beneficiaries_reservation_path(@reservation), notice: t('.success')
        else
          redirect_to users_beneficiaries_reservation_path(@reservation), alert: t('.failure')
        end
      end

      private

      def create_reservation
        if @reservation.save
          @offer.decrement!(:remaining_quantity) # rubocop:disable Rails/SkipsModelValidations
          redirect_to users_beneficiaries_reservation_path(@reservation), notice: t('.success')
        else
          redirect_with_error(t('.failure'))
        end
      end

      def set_offer
        @offer = Offer.find(reservation_params[:offer_id])
      end

      def set_reservation
        @reservation = current_user.beneficiary.reservations.find(params[:id])
      end

      def reservation_params
        params.require(:reservation).permit(:offer_id)
      end

      def redirect_with_error(alert)
        redirect_to users_beneficiaries_offer_path(@offer), alert:
      end
    end
  end
end
