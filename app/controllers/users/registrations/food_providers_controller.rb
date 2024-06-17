# frozen_string_literal: true

module Users
  module Registrations
    class FoodProvidersController < ApplicationController
      before_action :set_food_provider, only: %i[show edit update destroy]

      # # GET /food_providers or /food_providers.json
      # def index
      #   @food_providers = FoodProvider.all
      # end

      # GET /food_providers/1 or /food_providers/1.json
      def show; end

      # GET /food_providers/new
      def new
        @food_provider = current_user.build_food_provider
      end

      # GET /food_providers/1/edit
      def edit; end

      # POST /food_providers or /food_providers.json
      def create
        @food_provider = current_user.build_food_provider(food_provider_params)

        respond_to do |format|
          if @food_provider.save
            format.html do
              redirect_to users_registrations_food_providers_path(@food_provider),
                          notice: 'Udało się zapisać dane twojego lokalu'
            end
            format.json { render :new, status: :created, location: @food_provider }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @food_provider.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /food_providers/1 or /food_providers/1.json
      def update
        respond_to do |format|
          if @food_provider.update(food_provider_params)
            format.html do
              redirect_to users_registrations_food_providers_path(@food_provider),
                          notice: 'Udało się zapisać dane twojego lokalu'
            end
            format.json { render :new, status: :ok, location: @food_provider }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @food_provider.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /food_providers/1 or /food_providers/1.json
      def destroy
        @food_provider.destroy!

        respond_to do |format|
          format.html { redirect_to food_providers_url, notice: 'Food provider was successfully destroyed.' }
          format.json { head :no_content }
        end
      end

      private

      def set_food_provider
        @food_provider = FoodProvider.find_by!(user: current_user)
      end

      def food_provider_params
        params.require(:food_provider).permit(:name, :provider_type, :address, :nip, :phone, :email,
                                              :description, :opening_time)
      end
    end
  end
end
