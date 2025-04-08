# frozen_string_literal: true

module Users
  module Registrations
    class BeneficiariesController < ApplicationController
      before_action :validate_user_access, only: %i[new create]

      def show
        beneficiary
      end

      def new
        return redirect_to edit_users_registrations_beneficiaries_path if current_user.beneficiary

        @beneficiary = current_user.build_beneficiary
      end

      def edit
        return redirect_to new_users_registrations_beneficiaries_path unless current_user.beneficiary

        set_beneficiary
      end

      def create # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
        @beneficiary = current_user.build_beneficiary(beneficiary_params)
        beneficiary.email = current_user.email unless beneficiary.email?
        beneficiary.user.state_event = :verify unless current_user.verifying?

        respond_to do |format|
          if beneficiary.save
            format.html do
              redirect_to users_registrations_beneficiaries_path, notice: 'Dane Beneficjenta zostały zapisane'
            end
            format.json { render :show, status: :created, location: beneficiary }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: beneficiary.errors, status: :unprocessable_entity }
          end
        end
      end

      def update # rubocop:disable Metrics/MethodLength
        respond_to do |format|
          if beneficiary.update(beneficiary_params)
            format.html do
              redirect_to edit_users_registrations_beneficiaries_path, notice: 'Dane Beneficjenta zostały zapisane'
            end
            format.json { render :show, status: :ok, location: beneficiary }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: beneficiary.errors, status: :unprocessable_entity }
          end
        end
      end

      private

      def beneficiary
        @beneficiary ||= Beneficiary.find_by!(user: current_user)
      end

      def beneficiary_params
        params.require(:beneficiary).permit(:name, :address, :description, :phone, :email, :state)
      end

      def validate_user_access
        return unless current_user.food_provider.present? || !current_user.type_confirmed?

        redirect_to root_path, alert: 'Nie masz dostępu do tej strony'
      end
    end
  end
end
