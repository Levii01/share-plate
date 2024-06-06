# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_paper_trail_whodunnit

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      # render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
      format.json { head :forbidden }
      format.html { redirect_to main_app.root_url, alert: exception.message }
      format.js   { render nothing: true, status: :not_found }
    end
  end
end
