# frozen_string_literal: true

module Users
  class PanelController < ApplicationController
    before_action :authenticate_user!

    def index; end
  end
end
