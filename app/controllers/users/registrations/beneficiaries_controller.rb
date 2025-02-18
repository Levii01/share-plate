# frozen_string_literal: true

module Users
  module Registrations
    class BeneficiariesController < ApplicationController
      before_action :set_beneficiary, only: %i[show update]

      # GET /beneficiaries or /beneficiaries.json
      # def index
      #   @beneficiaries = Beneficiary.all
      # end

      # GET /beneficiaries/1 or /beneficiaries/1.json
      def show; end

      # GET /beneficiaries/new
      def new
        return redirect_to edit_users_registrations_beneficiaries_path if current_user.beneficiary

        @beneficiary = current_user.build_beneficiary
      end

      # GET /beneficiaries/1/edit
      def edit
        return redirect_to new_users_registrations_beneficiaries_path unless current_user.beneficiary

        set_beneficiary
      end

      # POST /beneficiaries or /beneficiaries.json
      def create
        @beneficiary = current_user.build_beneficiary(beneficiary_params)
        @beneficiary.email = current_user.email unless @beneficiary.email?
        @beneficiary.user.state_event = :verify unless current_user.verifying?

        respond_to do |format|
          if @beneficiary.save
            format.html do
              redirect_to users_registrations_beneficiaries_path, notice: 'Dane Beneficjenta zostały zapisane'
            end
            format.json { render :show, status: :created, location: @beneficiary }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @beneficiary.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /beneficiaries/1 or /beneficiaries/1.json
      def update
        @beneficiary.assign_attributes(beneficiary_params)

        respond_to do |format|
          if @beneficiary.save
            format.html do
              redirect_to edit_users_registrations_beneficiaries_path, notice: 'Dane Beneficjenta zostały zapisane'
            end
            format.json { render :show, status: :ok, location: @beneficiary }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @beneficiary.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /beneficiaries/1 or /beneficiaries/1.json
      # def destroy
      #   @beneficiary.destroy!
      #
      #   respond_to do |format|
      #     format.html { redirect_to beneficiaries_url, notice: 'Beneficiary was successfully destroyed.' }
      #     format.json { head :no_content }
      #   end
      # end

      private

      def set_beneficiary
        @beneficiary = Beneficiary.find_by!(user: current_user)
      end

      def beneficiary_params
        params.require(:beneficiary).permit(:name, :user_id, :address, :description, :phone, :email, :state)
      end
    end
  end
end
