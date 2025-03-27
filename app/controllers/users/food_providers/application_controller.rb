# frozen_string_literal: true

module Users
  module FoodProviders
    class ApplicationController < ::ApplicationController
      before_action :authenticate_user!
      before_action :require_food_provider!
      load_and_authorize_resource
    end
  end
end
