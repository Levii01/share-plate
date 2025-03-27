# frozen_string_literal: true

module Users
  module Beneficiaries
    class ApplicationController < ::ApplicationController
      before_action :authenticate_user!
      before_action :require_beneficiary!
      load_and_authorize_resource
    end
  end
end
