# frozen_string_literal: true

module Users
  module Registrations
    class FoodProvidersController < ApplicationController
      before_action :validate_user_access, only: %i[new create]
      before_action :food_provider, only: %i[show edit]

      def show; end

      def new
        return redirect_to edit_users_registrations_food_providers_path if current_user.food_provider

        @food_provider = current_user.build_food_provider
      end

      def edit; end

      def create # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
        @food_provider = current_user.build_food_provider(food_provider_params)
        food_provider.email = current_user.email unless food_provider.email?
        food_provider.user.state_event = :verify unless current_user.verifying?

        respond_to do |format|
          if food_provider.save
            format.html do
              redirect_to users_registrations_food_providers_path(food_provider),
                          notice: 'Dane lokalu zostały zapisane'
            end
            format.json { render :new, status: :created, location: food_provider }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: food_provider.errors, status: :unprocessable_entity }
          end
        end
      end

      def update # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
        respond_to do |format|
          if food_provider.update(food_provider_params)
            format.html do
              redirect_to users_registrations_food_providers_path(food_provider),
                          notice: 'Dane lokalu zostały zapisane'
            end
            format.json { render :new, status: :ok, location: food_provider }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: food_provider.errors, status: :unprocessable_entity }
          end
        end
      end

      private

      def food_provider
        @food_provider ||= ::FoodProvider.find_by!(user: current_user)
      end

      def food_provider_params
        params.require(:food_provider).permit(:name, :provider_type, :address, :nip, :phone, :email,
                                              :description, :opening_time)
      end

      def validate_user_access
        return unless current_user.beneficiary.present? || !current_user.type_confirmed?

        redirect_to root_path, alert: 'Nie masz dostępu do tej strony'
      end
    end
  end
end
