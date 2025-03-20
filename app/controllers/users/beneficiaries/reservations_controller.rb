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
      end

      # Tworzenie rezerwacji
      def create
        @reservation = current_user.beneficiary.reservations.new(offer: @offer)

        if @reservation.save
          redirect_to users_beneficiaries_reservation_path(@reservation),
                      notice: 'Rezerwacja została pomyślnie utworzona.'
        else
          redirect_to users_beneficiaries_offer_path(@offer), alert: 'Nie udało się utworzyć rezerwacji.'
          # render :new, alert: 'Nie udało się utworzyć rezerwacji.'
        end
      end

      # Oznaczanie rezerwacji jako odebraną
      def update
        if @reservation.update(picked_up_datetime: Time.current, status: 'completed')
          redirect_to @reservation, notice: 'Rezerwacja została oznaczona jako odebrana.'
        else
          render :show, alert: 'Nie udało się zaktualizować rezerwacji.'
        end
      end

      # Anulowanie rezerwacji
      def destroy
        if @reservation.update(status: 'cancelled')
          redirect_to offers_path, notice: 'Rezerwacja została anulowana.'
        else
          redirect_to offers_path, alert: 'Nie udało się anulować rezerwacji.'
        end
      end

      private

      def set_offer
        @offer = Offer.find(reservation_params[:offer_id])
      end

      def set_reservation
        @reservation = Reservation.find(params[:id])
      end

      def reservation_params
        params.require(:reservation).permit(:offer_id)
      end
    end
  end
end
