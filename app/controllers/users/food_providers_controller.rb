# frozen_string_literal: true

module Users
  class FoodProvidersController < ApplicationController
    before_action :authenticate_user!
    before_action :require_food_provider!
    before_action :food_provider, only: %i[edit update]

    def edit; end

    def update
      if food_provider.update(food_provider_params)
        redirect_to users_food_provider_path, notice: 'Dane lokalu zostały zapisane'
      else
        render :edit, status: :unprocessable_entity
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
