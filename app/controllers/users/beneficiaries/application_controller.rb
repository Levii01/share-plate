# frozen_string_literal: true

module Users
  module Beneficiaries
    class ApplicationController < ::ApplicationController
      before_action :authenticate_user!
    end
  end
end
