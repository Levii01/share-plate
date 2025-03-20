# frozen_string_literal: true

module Users
  class BeneficiariesController < ApplicationController
    before_action :beneficiary, only: %i[edit update]

    def edit; end

    def update
      if @beneficiary.update(beneficiary_params)
        redirect_to edit_users_beneficiary_path, notice: 'Dane Beneficjenta zostały zapisane'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def beneficiary
      @beneficiary ||= Beneficiary.find_by!(user: current_user)
    end

    def beneficiary_params
      params.require(:beneficiary).permit(:name, :address, :description, :phone, :email, :state)
    end
  end
end
