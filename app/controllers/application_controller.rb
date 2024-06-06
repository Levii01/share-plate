# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_paper_trail_whodunnit

  before_action :finish_registration

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      # render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
      format.json { head :forbidden }
      format.html { redirect_to main_app.root_url, alert: exception.message }
      format.js   { render nothing: true, status: :not_found }
    end
  end

  def finish_registration
    return if current_user.blank? || controller_name == 'chose_profile'

    redirect_to users_registrations_chose_profile_index_path if current_user.initialized?
  end
end
