# frozen_string_literal: true

module Users
  module Registrations
    class AccountTypesController < ApplicationController
      before_action :user

      def edit; end

      def update
        user.assign_attributes(update_params.merge(state: 'type_confirmed'))

        respond_to do |format|
          if user.state_was == 'initialized' && user.save
            format.html do
              redirect_to new_users_registrations_food_providers_path if current_user.account_food_provider?
              redirect_to new_users_registrations_beneficiaries_path if current_user.account_beneficiary?
            end
            format.json { render :show, status: :ok, location: @resource }
            format.js   { render :update } # Add this for handling JavaScript responses
          else
            flash[:error] = 'Coś poszło nie tak. Skontaktuj się z administracją.'
            format.html { redirect_to edit_users_registrations_account_types_path }
            # format.html { render :edit }
            format.json { render json: user.errors, status: :unprocessable_entity }
            format.js   { render :edit }
          end
        end
      end

      private

      def user
        @user ||= current_user
      end

      def update_params
        params.require(:user).permit(:account_type)
      end
    end
  end
end
