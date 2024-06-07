# frozen_string_literal: true

module Users
  module Registrations
    class AccountTypesController < ApplicationController
      before_action :authenticate_user!

      def show; end

      def update
        current_user.update(update_params)
      end

      private

      def update_params
        params.require(:user).permit(:account_type)
      end
    end
  end
end
