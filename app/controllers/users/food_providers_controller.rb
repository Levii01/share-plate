# frozen_string_literal: true

module Users
  class FoodProvidersController < ApplicationController
    before_action :food_provider, only: %i[edit update]

    # GET /food_providers/1/edit
    def edit; end

    def update
      respond_to do |format|
        if food_provider.update(food_provider_params)
          format.html do
            redirect_to users_registrations_food_providers_path(food_provider), notice: 'Dane lokalu zostały zapisane'
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
  end
end
